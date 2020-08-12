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
