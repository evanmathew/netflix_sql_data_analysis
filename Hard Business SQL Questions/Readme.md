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

### 5. ** Top 10 actor who played most movies**

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




### 6. ** Title Diversity by Country**

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


