-------------------------------------------------------------------
-- EASY SQL Questions:

-- Q)1 Total Movies and TV Shows
  SELECT type, COUNT(*) AS Total_Number FROM netflix
  GROUP BY type

-- Q)2 Most Popular Genre
  SELECT listed_in  FROM NETFLIX
  GROUP BY listed_in
  ORDER BY COUNT(*) DESC
  LIMIT 5

-- Q)3 Content by Year
    SELECT EXTRACT(Year FROM date_added) AS year_added ,
    COUNT(*) as content_count
    FROM netflix
    WHERE date_added IS NOT NULL
    GROUP BY year_added
    ORDER BY year_added ASC

-- Q)4 Top Countries by Content
    SELECT 
        TRIM(country_name) AS country, 
        COUNT(*) AS content_count
    FROM (
        SELECT 
            UNNEST(string_to_array(country, ',')) AS country_name
        FROM 
            netflix
    ) AS countries
    GROUP BY 
        TRIM(country_name)
    ORDER BY 
        content_count DESC;
   
-- Q)5 Recent Additions
    SELECT title ,date_added FROM netflix
    WHERE date_added IS NOT NULL
    ORDER BY date_added DESC
      
-- Q)6 Longest Movie or TV Show
    SELECT title ,duration, type FROM netflix
    WHERE duration IS NOT NULL
    ORDER BY duration DESC, title ASC

-- Q)7 Specific Genre Analysis
    
-- Q)8 Count the number of Movies vs TV Shows
-- Q)9 Find the most common rating for movies and TV shows
-- Q)10 List all movies released in a specific year (e.g., 2020)
-- Q)5List all movies that are documentaries
-- Q)5Find content added in the last 5 years
