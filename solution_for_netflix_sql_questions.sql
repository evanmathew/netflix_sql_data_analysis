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
    

    
Recent Additions
Longest Movie or TV Show
Specific Genre Analysis
Count the number of Movies vs TV Shows
Find the most common rating for movies and TV shows
List all movies released in a specific year (e.g., 2020)
List all movies that are documentaries
Find content added in the last 5 years
