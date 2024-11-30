<h1>Hard SQL Questions with Answers and Objectives </h1>


### 1. **Identify Titles with Maximum Longevity**

- **Question**:  Identify Titles with Maximum Longevity.

- **Answer**:
  ```sql
  SELECT title, CAST(REGEXP_REPLACE(duration, '[^0-9]', '', 'g') AS INT) FROM netflix
  WHERE duration iS NOT NULL	
  ORDER BY CAST(REGEXP_REPLACE(duration, '[^0-9]', '', 'g') AS INT) DESC 
  LIMIT 5;
  ```
    



### 2. **Find cast who has acted in most of the content**

- **Question**:  Identify Titles with Maximum Longevity.

- **Answer**:
  ```sql
  WITH cast_format AS (
  	SELECT UNNEST(string_to_array(casts,',')) AS actors, 
  	title 
  	FROM netflix
  	)
  	
  SELECT TRIM(REGEXP_REPLACE(actors, '''', '', 'g')) AS actors,
  COUNT(*) AS no_of_contents
  FROM cast_format
  GROUP BY actors
  ORDER BY no_of_contents DESC
  ```
    


### 3. **Find Top 3 Genres by Release Year**

- **Question**: Find Top 3 Genres by Release Yea

- **Answer**:
  ```sql
  WITH CTE AS (
      SELECT
        release_year,
  		  TRIM(UNNEST(string_to_array(listed_in,','))) AS genre,
  		  COUNT(*) AS no_of_content,
  		  RANK() OVER(PARTITION BY release_year ORDER BY COUNT(*) DESC) AS ranks
  		  FROM netflix 
      GROUP BY genre, release_year 
  		ORDER BY release_year DESC, ranks ASC )
  
  SELECT * FROM CTE
  WHERE ranks<4
  ```
    
### 4. **Actor who roled for any movie or tv show in the last 10 years**

- **Question**: Find how many movies actor 'Salman Khan' appeared in last 10 years!

- **Answer**:
  ```sql
  WITH cast_format AS (
      SELECT 
          REGEXP_REPLACE(TRIM(UNNEST(string_to_array(casts, ','))), '''', '', 'g') AS actors, 
          title,
          release_year
      FROM netflix
  ),
  latest_years AS (
      SELECT MAX(release_year) AS max_year FROM netflix
  )
  SELECT actors, COUNT(*) as no_of_content
  FROM cast_format, latest_years
  WHERE release_year BETWEEN max_year - 10 AND max_year
  GROUP BY actors
  HAVING actors = 'Salman Khan'
  ```

### 5. **Top 10 actor who played most movies**

- **Question**: Find the top 10 actors who have appeared in the highest number of movies produced in India.
- **Answer**:
  ```sql
  WITH top_rank_actor_of_content AS (SELECT 
  REGEXP_REPLACE(TRIM(UNNEST(string_to_array(casts, ','))), '''', '', 'g') AS actors, 
  count(title) as no_of_movies,
  DENSE_RANK() OVER(ORDER BY COUNT(title) DESC) as top_most_acted_actor
  FROM netflix
  WHERE type='Movie'
  GROUP BY actors
  ORDER BY top_most_acted_actor ASC
  )
  
  SELECT * FROM top_rank_actor_of_content
  WHERE top_most_acted_actor < 11
  ```




### 6. **Title Diversity by Country**

- **Question**: List all the title produced by their country 
- **Answer**:
  ```sql
  WITH CTE AS (
      SELECT 
          TRIM(UNNEST(string_to_array(country, ','))) AS country,
          title
      FROM netflix
      WHERE country IS NOT NULL
  )
  SELECT *
  FROM CTE
  WHERE country != ''
  ORDER BY country;
  ```


### 7. **Top-Performing Directors by Genre**

- **Question**: Find top most directors of every genre 
- **Answer**:
  ```sql
  WITH genre_format AS (
      SELECT 
          title,
          director,
          TRIM(UNNEST(string_to_array(listed_in, ','))) AS genre
      FROM netflix
      WHERE director IS NOT NULL
  )
  ,CTE AS (
  SELECT 
      genre,
      director,
      COUNT(*) AS title_count,
      DENSE_RANK() OVER (PARTITION BY genre ORDER BY COUNT(*) DESC) AS top_genre_rank
  FROM genre_format
  GROUP BY genre, director
  ORDER BY top_genre_rank ASC, genre)
  
  SELECT * FROM CTE 
  WHERE top_genre_rank<2
  ```

### 8. **Trending Content Additions**

- **Question A**: Identify time-based insights, such as determining spike which years or months saw the most content additions
- **Answer**:
  ```sql
  WITH CTE AS (
  	SELECT 
  		EXTRACT(YEAR FROM date_added) AS year_added, 
  		TO_CHAR(date_added, 'Month') AS month_added,
  		EXTRACT(MONTH FROM date_added) AS month_numb,
  		COUNT(*) as no_of_content
  	FROM netflix
  	WHERE date_added IS NOT NULL
  	GROUP BY year_added,month_added, month_numb
  	ORDER BY year_added DESC, month_numb ASC
  )
  
  SELECT 
  	year_added, month_added, no_of_content 
  FROM CTE
  ```
  

- **Question B**: Identify genre's trends and determine which genres are gaining popularity in recent years
- **Answer**:
  ```sql
  WITH genre_format AS (
      SELECT 
          TRIM(UNNEST(string_to_array(listed_in, ','))) AS genre,
          EXTRACT(YEAR FROM date_added) AS year_added
      FROM netflix
      WHERE date_added IS NOT NULL
  ),
  rank_dist AS (
  	SELECT 
      	year_added,
      	genre,
      	COUNT(*) AS total_titles,
  		DENSE_RANK() OVER (PARTITION BY year_added ORDER BY COUNT(genre) DESC) AS ranks
  	FROM genre_format
  	GROUP BY year_added, genre
  	ORDER BY year_added DESC, total_titles DESC, ranks ASC )
  	
  SELECT * FROM rank_dist
  WHERE ranks < 4

  ```

### 9. **Genre Growth Over Time**

- **Question A**: Identify the track how the availability of each genre evolves across years
- **Answer**:
  ```sql
  WITH genre_growth AS (
      SELECT 
          TRIM(UNNEST(string_to_array(listed_in, ','))) AS genre,
          EXTRACT(YEAR FROM date_added) AS year_added
      FROM netflix
      WHERE date_added IS NOT NULL
  )
  SELECT 
      year_added,
      genre,
      COUNT(*) AS total_titles
  FROM genre_growth
  GROUP BY year_added, genre
  ORDER BY genre ASC, year_added ASC;

  ```

### 10. **Missing Data Impact**

- **Question A**: Assess how much data is missing in each column and how that might affect your ability to extract meaningful insights from the dataset
- **Answer**:
  ```sql
  SELECT 
      'director' AS column_name, 
      COUNT(*) AS missing_count,
      ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix), 2) AS missing_percentage
  FROM netflix
  WHERE director IS NULL
  
  UNION ALL
  
  SELECT 
      'country' AS column_name, 
      COUNT(*) AS missing_count,
      ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix), 2) AS missing_percentage
  FROM netflix
  WHERE country IS NULL
  
  UNION ALL
  
  SELECT 
      'date_added' AS column_name, 
      COUNT(*) AS missing_count,
      ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix), 2) AS missing_percentage
  FROM netflix
  WHERE date_added IS NULL
  
  UNION ALL
  
  SELECT 
      'rating' AS column_name, 
      COUNT(*) AS missing_count,
      ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix), 2) AS missing_percentage
  FROM netflix
  WHERE rating IS NULL;
  ```
