<h1>Hard SQL Questions with Answers and Objectives </h1>


### 1. ** Identify Titles with Maximum Longevity**

- **Question**:  Identify Titles with Maximum Longevity.

- **Answer**:
  ```sql
  SELECT title, CAST(REGEXP_REPLACE(duration, '[^0-9]', '', 'g') AS INT) FROM netflix
  WHERE duration iS NOT NULL	
  ORDER BY CAST(REGEXP_REPLACE(duration, '[^0-9]', '', 'g') AS INT) DESC 
  LIMIT 5;
  ```
    



### 2. ** Find cast who has acted in most of the content**

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
    

