-------------------------------------------------------------------
-- MEDIUM SQL Questions:

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
