-------------------------------------------------------------------
-- MEDIUM DIFFICULTY SQL QUESTIONS:

-- Q)1 Director with Most Titles
    SELECT director, COUNT(*) AS no_of_titles FROM netflix
    WHERE director IS NOT NULL
    GROUP BY director
    ORDER BY no_of_titles DESC
    LIMIT 5

-- Q)2 Multi-Country Productions
    SELECT
    title,
    country
    FROM netflix
    WHERE array_length(string_to_array(country, ','), 1) > 1;

-- Q)3 Content by Rating
    SELECT rating , COUNT(*) AS no_of_content
    FROM netflix
    WHERE rating IS NOT NULL AND NOT rating ~ ' min$'
    GROUP BY rating
    ORDER BY no_of_content DESC

-- Q)4 Duplicate Titles
    SELECT title, COUNT(*) AS no_of_dup
    FROM netflix
    GROUP BY title
    HAVING COUNT(*) > 1

-- Q)5 Yearly Additions
    SELECT EXTRACT(YEAR FROM date_added) AS year_of_addition,
    COUNT(*) AS no_of_content
    FROM NETFLIX
    WHERE date_added IS NOT NULL
    GROUP BY year_of_addition
    ORDER BY year_of_addition DESC

-- Q)6  Find all the movies/TV shows by director 'Rajiv Chilaka'
    SELECT title 
    FROM netflix
    WHERE director ~* '(Rajiv Chilaka)'

-- Q)7 List all TV shows with more than 5 seasons 
    SELECT title
    FROM netflix
    WHERE type='TV Show' AND CAST((string_to_array(duration,' '))[1] AS INTEGER)>5

-- Q)8 Count the number of content items in each genre
    SELECT TRIM(genre) AS genre,
    COUNT(*) AS no_of_content 
    FROM (
    SELECT UNNEST(string_to_array(listed_in,',')) AS genre
    	FROM netflix
    )
    GROUP BY genre
    ORDER BY no_of_content DESC

-- Q)9 
