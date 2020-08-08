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

-- LESSON 3
-- Sub-queries
-- Uncorrelated sub-query
-- In uncorrelated sub-queries, the sub-query does not reference the
-- outer query and therefore can run independently of the outer query.
SELECT UNStatisticalRegion,
       CountryName
FROM Nations
WHERE Code2 -- Country code for outer query
         IN (SELECT Country -- Country code for sub-query
             FROM Earthquakes
             WHERE depth >= 400 ) -- Depth filter
ORDER BY UNStatisticalRegion;

-- Correlated sub-query
-- In correlated sub-queries, the outer query is referenced in the sub-query.
SELECT UNContinentRegion,
       CountryName,
        (SELECT AVG(magnitude) -- Add average magnitude
        FROM Earthquakes e
         	  -- Add country code reference
        WHERE n.Code2 = e.Country) AS AverageMagnitude
FROM Nations n
ORDER BY UNContinentRegion DESC,
         AverageMagnitude DESC;

-- Subquery vs INNER JOIN
SELECT
	n.CountryName,
	 (SELECT MAX(c.Pop2017) -- Add 2017 population column
	 FROM Cities AS c
                       -- Outer query country code column
	 WHERE c.CountryCode = n.Code2) AS BiggestCity
FROM Nations AS n; -- Outer query table

SELECT n.CountryName,
       c.BiggestCity
FROM Nations AS n
INNER JOIN -- Join the Nations table and sub-query
    (SELECT CountryCode,
     MAX(Pop2017) AS BiggestCity
     FROM Cities
     GROUP BY CountryCode) AS c
ON n.Code2 = c.CountryCode; -- Add the joining columns

-- Sub-queries and INNER JOIN's can be used to return the same results. However,
-- in practice large, complex queries  may contain lots of sub-queries, many of
-- which could be re-written as INNER JOIN's to improve performance


-- Presence and absence
-- INTERSECT: Appears on both tables
SELECT Capital
FROM Nations -- Table with capital cities

INTERSECT -- Add the operator to compare the two queries

SELECT NearestPop -- Add the city name column
FROM Earthquakes;

-- EXCEPT: Get all CountryCodes from Nations that are not in Earthquakes table
SELECT Code2 -- Add the country code column
FROM Nations

EXCEPT -- Add the operator to compare the two queries

SELECT Country
FROM Earthquakes; -- Table with country codes


SELECT CountryName
FROM Nations -- Table from Earthquakes database

INTERSECT -- Operator for the intersect between tables

SELECT Country
FROM Players; -- Table from NBA Season 2017-2018 database


-- Alternative methods
-- IN vs EXISTS
-- First attempt
SELECT CountryName,
       Pop2017, -- 2017 country population
	   Capital, -- Capital city
       WorldBankRegion
FROM Nations
WHERE Capital IN -- Add the operator to compare queries
        (SELECT NearestPop
	     FROM Earthquakes);

-- Second attempt
SELECT CountryName,
	   Capital,
       Pop2016, -- 2016 country population
       WorldBankRegion
FROM Nations AS n
WHERE EXISTS -- Add the operator to compare queries
	  (SELECT 1
	   FROM Earthquakes AS e
	   WHERE n.Capital = e.NearestPop); -- Columns being compared

-- NOT IN vs NOT EXISTS
SELECT WorldBankRegion,
       CountryName
FROM Nations
WHERE Code2 NOT EXISTS -- Add the operator to compare queries
	(SELECT CountryCode -- Country code column
	 FROM Cities);

-- NOT IN with IS NOT NULL
SELECT WorldBankRegion,
       CountryName,
       Capital -- Capital city name column
FROM Nations
WHERE Capital NOT IN
	(SELECT NearestPop -- City name column
     FROM Earthquakes);
-- Returns nothing

SELECT WorldBankRegion,
       CountryName,
       Capital
FROM Nations
WHERE Capital NOT IN
	(SELECT NearestPop
     FROM Earthquakes
     WHERE NearestPop IS NOT NULL); -- filter condition
-- Returns rows


-- Alternative 2
-- Initial query
SELECT TeamName,
       TeamCode,
	   City
FROM Teams AS t -- Add table
WHERE EXISTS -- Operator to compare queries
      (SELECT 1
	  FROM Earthquakes AS e -- Add table
	  WHERE t.City = e.NearestPop);

-- Second query
SELECT t.TeamName,
       t.TeamCode,
	   t.City,
	   e.Date,
	   e.Place, -- Place description
	   e.Country -- Country code
FROM Teams AS t
INNER JOIN Earthquakes AS e -- Operator to compare tables
	  ON t.City = e.NearestPop


-- LEFT OUTER JOIN example
-- Second attempt
SELECT c.CustomerID,
       c.CompanyName,
	   c.ContactName,
	   c.ContactTitle,
	   c.Phone
FROM Customers c
LEFT OUTER JOIN Orders o
	ON c.CustomerID = o.CustomerID
WHERE c.Country = 'France'
	AND o.CustomerID IS NULL; -- Filter condition

