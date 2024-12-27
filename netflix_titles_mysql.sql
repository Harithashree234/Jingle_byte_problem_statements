-- creation of database
CREATE DATABASE festive_movie_preferences;
USE festive_movie_preferences;
DROP DATABASE festive_movie_preferences;

-- To view the table attributes
SELECT * FROM netflix_titles;
DESC netflix_titles;

-- Imported the data using "Table import wizard"

-- Data Cleaning
ALTER TABLE netflix_titles
MODIFY COLUMN date_added DATE;
ALTER TABLE netflix_titles
MODIFY COLUMN release_year YEAR;
ALTER TABLE netflix_titles
MODIFY COLUMN show_id VARCHAR(30);
ALTER TABLE netflix_titles
CHANGE COLUMN type show_type VARCHAR(30);
ALTER TABLE netflix_titles
MODIFY COLUMN title VARCHAR(250);
ALTER TABLE netflix_titles
MODIFY COLUMN director VARCHAR(250);
ALTER TABLE netflix_titles
MODIFY COLUMN cast VARCHAR(2000);
ALTER TABLE netflix_titles
MODIFY COLUMN country VARCHAR(250);
ALTER TABLE netflix_titles
MODIFY COLUMN rating VARCHAR(250);
ALTER TABLE netflix_titles
MODIFY COLUMN duration VARCHAR(250);
ALTER TABLE netflix_titles
MODIFY COLUMN listed_in VARCHAR(250);
ALTER TABLE netflix_titles
MODIFY COLUMN description VARCHAR(250);

UPDATE netflix_titles
SET date_added = STR_TO_DATE(date_added, '%M %d, %Y');


-- View Table Structure and Data
-- Check first 10 rows of the table
SELECT * FROM netflix_titles LIMIT 10;


-- Check for Missing or NULL Values
-- Count NULL values for each column
SELECT 
    COUNT(*) AS total_rows,
    COUNT(CASE WHEN title IS NULL THEN 1 END) AS title_nulls,
    COUNT(CASE WHEN director IS NULL THEN 1 END) AS director_nulls,
    COUNT(CASE WHEN country IS NULL THEN 1 END) AS country_nulls,
    COUNT(CASE WHEN date_added IS NULL THEN 1 END) AS date_added_nulls,
    COUNT(CASE WHEN rating IS NULL THEN 1 END) AS rating_nulls
FROM netflix_titles;


-- Analysis:


-- 1. Find Total Movies vs. TV Shows
SELECT show_type, COUNT(*) AS total_count
FROM netflix_titles
GROUP BY show_type;


-- 2. List of top 10 directors with the most titles
SELECT director, COUNT(*) AS total_titles
FROM netflix_titles
WHERE director IS NOT NULL
GROUP BY director
ORDER BY total_titles DESC
LIMIT 10;


-- 3. Count how many times each listed genre appears
SELECT listed_in AS genre, COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY listed_in
ORDER BY total_titles DESC
LIMIT 10;


-- 4. Number of titles released each year
SELECT release_year, COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY release_year
ORDER BY release_year DESC;


-- 5. Count of titles added to Netflix over time
SELECT 
YEAR(date_added) AS year_added, 
COUNT(*) AS total_titles_added
FROM netflix_titles
WHERE date_added IS NOT NULL
GROUP BY YEAR(date_added)
ORDER BY year_added DESC;


-- 6. Count of titles per country
SELECT country, COUNT(*) AS total_titles
FROM netflix_titles
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total_titles DESC
LIMIT 10;


-- 7. Find all movies with 'PG-13' rating
SELECT title, show_type, rating, release_year
FROM netflix_titles
WHERE rating = 'PG-13'
AND show_type = 'Movie'
ORDER BY release_year DESC;


-- 8. Most Popular Release Years for Movies and TV Shows
SELECT release_year, show_type, COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY release_year, show_type
ORDER BY total_titles DESC
LIMIT 10;


-- 9. Recent releases
SELECT 
    title, 
    release_year, 
    date_added
FROM netflix_titles
WHERE show_type = 'Movie'
ORDER BY release_year DESC, date_added DESC
LIMIT 5;
