USE movies_schema;

-- Runtime and Popularity:
-- Hypothesis 1: Optimal Movie Runtime and Success Metrics

SELECT 
    MIN(runtime) AS min_runtime,
    MAX(runtime) AS max_runtime,
    AVG(runtime) AS avg_runtime
FROM movies_schema.movies_metadata;

SELECT 
    CASE 
        WHEN runtime BETWEEN 0 AND 90 THEN '0-1h30'
        WHEN runtime BETWEEN 91 AND 120 THEN '1h30-2h'
        WHEN runtime BETWEEN 121 AND 180 THEN '2h-3h'
        ELSE 'Over 3h'
    END AS runtime_range,
    AVG(popularity) AS avg_popularity
FROM movies_schema.movies_metadata
GROUP BY runtime_range
ORDER BY runtime_range;

-- Hypothesis 2:
-- Revenue Difference Between Action and War Genres

-- Calculate the average revenue for each genre
SELECT 
    genres AS genre,
    ROUND(AVG(revenue), 2) AS average_revenue
FROM 
    movies_schema.movies_metadata
WHERE 
    genres IS NOT NULL AND genres <> '' AND revenue IS NOT NULL
GROUP BY 
    genres
HAVING 
    AVG(revenue) IS NOT NULL
    AND AVG(revenue) > 0 -- Filter out genres with average revenue of 0
ORDER BY 
    average_revenue DESC;

-- Hypothesis 3:
-- Impact of Budget on User Ratings

SELECT 
    m.title,
    m.budget,
    ROUND(AVG(r.rating), 1) AS average_rating
FROM 
    movies_schema.movies_metadata m
JOIN 
    (SELECT DISTINCT movieId, userId, rating FROM movies_schema.ratings_small) r ON m.id = r.movieId
WHERE 
    m.budget IS NOT NULL
GROUP BY
    m.title,
    m.budget
ORDER BY 
    m.budget DESC
LIMIT 15;