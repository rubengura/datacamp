-- LESSON 1
-- SELECT the country column FROM the eurovision table
SELECT country FROM eurovision

-- Select the points column
SELECT
  points
FROM
  eurovision;

-- Limit the number of rows returned
SELECT
  TOP (50) points
FROM
  eurovision;

-- Return unique countries and use an alias
SELECT
  DISTINCT country AS unique_country
FROM
  eurovision;


-- Select country and event_year from eurovision
SELECT
  country,
  event_year
FROM
  eurovision;

-- Amend the code to select all rows and columns
SELECT
  *
FROM
  eurovision;

-- Return all columns, restricting the percent of rows returned
SELECT
  TOP (50) PERCENT *
FROM
  eurovision;

-- Select the first 5 rows from the specified columns
SELECT
  TOP (5) description,
  event_date
FROM
  grid
  -- Order your results by the event_date column
ORDER BY
  event_date;

-- Select the top 20 rows from description, nerc_region and event_date
SELECT
  TOP (20) description,
  nerc_region,
  event_date
FROM
  grid
  -- Order by nerc_region, affected_customers & event_date
  -- Event_date should be in descending order
ORDER BY
  nerc_region,
  affected_customers,
  event_date DESC;

-- Select description and event_year
SELECT
  description,
  event_year
FROM
  grid
  -- Filter the results
WHERE
  description = 'Vandalism';

-- Select nerc_region and demand_loss_mw
SELECT
  nerc_region,
  demand_loss_mw
FROM
  grid
-- Retrieve rows where affected_customers is >= 500000
WHERE
  affected_customers >= 500000;

-- Retrieve all columns
SELECT
  *
FROM
  grid
  -- Return only rows where demand_loss_mw is missing or unknown
WHERE
  demand_loss_mw IS NULL;

-- Retrieve all columns
SELECT
  *
FROM
  grid
  -- Return rows where demand_loss_mw is not missing or unknown
WHERE
  demand_loss_mw IS NOT NULL;

-- Retrieve the song,artist and release_year columns
SELECT
  song,
  artist,
  release_year
FROM
  songlist
  -- Ensure there are no missing or unknown values in the release_year column
WHERE
  release_year IS NOT NULL
  -- Arrange the results by the artist and release_year columns
ORDER BY
  artist,
  release_year;

SELECT
  song,
  artist,
  release_year
FROM
  songlist
WHERE
  -- Retrieve records greater than and including 1980
  release_year >= 1980
  -- Replace AND with OR
  OR release_year <= 1990
ORDER BY
  artist,
  release_year;

SELECT
  artist,
  release_year,
  song
FROM
  songlist
  -- Choose the correct artist and specify the release year
WHERE
  (
    artist LIKE 'B%'
    AND release_year = 1986
  )
  -- Or return all songs released after 1990
  OR release_year > 1990
  -- Order the results
ORDER BY
  release_year,
  artist,
  song;

-- LESSON 2
-- Sum the demand_loss_mw column
SELECT
  SUM(demand_loss_mw) AS MRO_demand_loss
FROM
  grid
WHERE
  -- demand_loss_mw should not contain NULL values
  demand_loss_mw IS NOT NULL
  -- and nerc_region should be 'MRO';
  AND nerc_region = 'MRO';

-- Obtain a count of 'grid_id'
SELECT
  COUNT(grid_id) AS RFC_count
FROM
  grid
-- Restrict to rows where the nerc_region is 'RFC'
WHERE
  nerc_region = 'RFC';


-- Find the minimum number of affected customers
SELECT
  MIN(affected_customers) AS min_affected_customers,
  MAX(affected_customers) AS max_affected_customers,
  AVG(affected_customers) AS avg_affected_customers
FROM
  grid
-- Only retrieve rows where demand_loss_mw has a value
WHERE
  demand_loss_mw IS NOT NULL;


-- Calculate the length of the description column
SELECT
  LEN (description) AS description_length
FROM
  grid;

-- Select the first 25 characters from the left of the description column
SELECT
  LEFT(description, 25) AS first_25_left,
  RIGHT(description, 25) AS last_25_right
FROM
  grid;

-- Complete the substring function to begin extracting from the correct character in the description column
SELECT TOP (10)
  description,
  CHARINDEX('Weather', description) AS start_of_string,
  LEN ('Weather') AS length_of_string,
  SUBSTRING(
    description,
    15,
    LEN(description)
  ) AS additional_description
FROM
  grid
WHERE description LIKE '%Weather%';

-- Select the region column
SELECT
  nerc_region,
  -- Sum the demand_loss_mw column
  SUM(demand_loss_mw) AS demand_loss
FROM
  grid
  -- Exclude NULL values of demand_loss
WHERE
  demand_loss_mw IS NOT NULL
  -- Group the results by nerc_region
GROUP BY
  nerc_region
  -- Order the results in descending order of demand_loss
ORDER BY
  demand_loss DESC;


SELECT
  nerc_region,
  SUM (demand_loss_mw) AS demand_loss
FROM
  grid
  -- Remove the WHERE clause
WHERE demand_loss_mw  IS NOT NULL
GROUP BY
  nerc_region
  -- Enter a new HAVING clause so that the sum of demand_loss_mw is greater than 10000
HAVING
  SUM(demand_loss_mw) > 10000
ORDER BY
  demand_loss DESC;



SELECT
  country,
  COUNT (country) AS country_count,
  AVG (place) AS avg_place,
  AVG (points) AS avg_points,
  MIN (points) AS min_points,
  MAX (points) AS max_points
FROM
  eurovision
GROUP BY
  country
  -- The country column should only contain those with a count greater than 5
HAVING
  COUNT(country) > 5
  -- Arrange columns in the correct order
ORDER BY
  avg_place,
  avg_points DESC;

