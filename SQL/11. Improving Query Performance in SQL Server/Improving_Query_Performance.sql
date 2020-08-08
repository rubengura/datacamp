-- LESSON 1
-- Good Practices
SELECT PlayerName, Country,
ROUND(Weight_kg/SQUARE(Height_cm/100),2) BMI
FROM Players
WHERE Country = 'USA'
OR Country = 'Canada'
ORDER BY BMI;

/*
Returns the Body Mass Index (BMI) for all North American players from the 2017-2018 NBA season
*/
SELECT PlayerName, Country,
    ROUND(Weight_kg/SQUARE(Height_cm/100),2) BMI
FROM Players
WHERE Country = 'USA'
    OR Country = 'Canada'
-- ORDER BY BMI;

-- Your friend's query
-- First attempt, contains errors and inconsistent formatting
/*
select PlayerName, p.Country,sum(ps.TotalPoints)
AS TotalPoints
FROM PlayerStats ps inner join Players On ps.PlayerName = p.PlayerName
WHERE p.Country = 'New Zeeland'
Group
by PlayerName, Country
order by Country;
*/

-- Your query
-- Second attempt - errors corrected and formatting fixed

SELECT p.PlayerName, p.Country,
		SUM(ps.TotalPoints) AS TotalPoints
FROM PlayerStats ps
INNER JOIN Players p
	ON ps.PlayerName = p.PlayerName
WHERE p.Country = 'New Zealand'
GROUP BY p.PlayerName, p.Country;

-- Aliasing
SELECT Team,
   ROUND(AVG(BMI),2) AS AvgTeamBMI -- Alias the new column
FROM PlayerStats AS ps -- Alias PlayerStats table
INNER JOIN
		(SELECT PlayerName, Country,
			Weight_kg/SQUARE(Height_cm/100) BMI
		 FROM Players) AS p -- Alias the sub-query
             -- Alias the joining columns
	ON ps.PlayerName = p.PlayerName
GROUP BY Team
HAVING AVG(BMI) >= 25;

/*
Returns earthquakes in New Zealand with a magnitude of 7.5 or more
*/
SELECT Date, Place, NearestPop, Magnitude
FROM Earthquakes
WHERE Country = 'NZ'
	AND Magnitude >= 7.5
ORDER BY Magnitude DESC;

-- Your query
SELECT Date,
    Place,
    NearestPop,
    Magnitude
FROM Earthquakes
WHERE Country = 'JP'
	AND Magnitude >= 8
ORDER BY Magnitude DESC;


/*
Returns the location of the epicenter of earthquakes with a 9+ magnitude
*/

-- Replace Countries with the correct table name
SELECT n.CountryName AS Country
	,e.NearestPop AS ClosestCity
    ,e.Date
    ,e.Magnitude
FROM Nations AS n
INNER JOIN Earthquakes AS e
	ON n.Code2 = e.Country
WHERE e.Magnitude >= 9
ORDER BY e.Magnitude DESC;

/*
Returns the location of the epicenter of earthquakes with a 9+ magnitude
*/

-- Replace Magnatud with the correct column name
SELECT n.CountryName AS Country
	,e.NearestPop AS ClosestCity
    ,e.Date
    ,e.magnitude AS Magnitude
FROM Nations AS n
INNER JOIN Earthquakes AS e
	ON n.Code2 = e.Country
WHERE e.magnitude >= 9
ORDER BY e.magnitude DESC;

/*
Location of the epicenter of earthquakes with a 9+ magnitude
*/

-- Replace City with the correct column name
SELECT n.CountryName AS Country
	,e.NearestPop AS ClosestCity
    ,e.Date
    ,e.Magnitude
FROM Nations AS n
INNER JOIN Earthquakes AS e
	ON n.Code2 = e.Country
WHERE e.Magnitude >= 9
ORDER BY e.Magnitude DESC;

-- Filtering with WHERE
-- First query

SELECT PlayerName,
    Team,
    Position,
    (DRebound+ORebound)/CAST(GamesPlayed AS numeric) AS AvgRebounds
FROM PlayerStats
WHERE (DRebound+ORebound)/CAST(GamesPlayed AS numeric) >= 12;

-- Second query

-- Add the new column to the select statement
SELECT PlayerName,
       Team,
       Position,
       AvgRebounds -- Add the new column
FROM
     -- Sub-query starts here
	(SELECT
      PlayerName,
      Team,
      Position,
      -- Calculate average total rebounds
     (DRebound+ORebound)/CAST(GamesPlayed AS numeric) AS AvgRebounds
	 FROM PlayerStats) tr
WHERE AvgRebounds >= 12; -- Filter rows

SELECT PlayerName,
      Country,
      College,
      DraftYear,
      DraftNumber
FROM Players
WHERE College LIKE 'Louisiana%';
                   -- Add the new wildcard filter

-- Filtering with HAVING
SELECT Country, COUNT(*) CountOfPlayers
FROM Players
-- Add the filter condition
WHERE COUNTRY
-- Fill in the missing countries
	IN ('Argentina','Brazil','Dominican Republic'
        ,'Puerto Rico')
GROUP BY Country;


SELECT Team,
	SUM(TotalPoints) AS TotalPFPoints
FROM PlayerStats
-- Filter for only rows with power forwards
WHERE Position = 'PF'
GROUP BY Team
-- Filter for total points greater than 3000
HAVING SUM(TotalPoints) > 3000;


SELECT latitude, -- Y location coordinate column
       longitude, -- X location coordinate column
	   magnitude , -- Earthquake strength column
	   depth, -- Earthquake depth column
	   NearestPop -- Nearest city column
FROM Earthquakes
WHERE Country = 'PG' -- Papua New Guinea country code
	OR Country = 'ID'; -- Indonesia country code

SELECT TOP 25 PERCENT -- Limit rows to the upper quartile
       Latitude,
       Longitude,
	   Magnitude,
	   Depth,
	   NearestPop
FROM Earthquakes
WHERE Country = 'PG'
	OR Country = 'ID'
ORDER BY Magnitude DESC; -- Order the results


SELECT NearestPop,
       Country,
       SUM(NearestPop) NumEarthquakes -- Number of cities
FROM Earthquakes
WHERE Magnitude >= 8
	AND Country IS NOT NULL
GROUP BY NearestPop, Country -- Group columns
ORDER BY NumEarthquakes DESC;

SELECT NearestPop,
       Country,
       SUM(NearestPop) NumEarthquakes -- Number of cities
FROM Earthquakes
WHERE Magnitude >= 8
	AND Country IS NOT NULL
GROUP BY NearestPop, Country -- Group columns
ORDER BY NumEarthquakes DESC;



SELECT CityName AS NearCityName, -- City name column
	   CountryCode
FROM Cities

UNION -- Append queries

SELECT Capital AS NearCityName, -- Nation capital column
       Code2 AS CountryCode
FROM Nations;


SELECT CityName AS NearCityName,
	   CountryCode
FROM Cities

UNION ALL -- Append queries

SELECT Capital AS NearCityName,
       Code2 AS CountryCode  -- Country code column
FROM Nations;