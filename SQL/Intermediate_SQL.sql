-- Calculate the average, minimum and maximum
SELECT AVG(DurationSeconds) AS Average,
       MIN(DurationSeconds) AS Minimum,
       MAX(DurationSeconds) AS Maximum
FROM Incidents

-- Calculate the aggregations by Shape
SELECT Shape,
       AVG(DurationSeconds) AS Average,
       MIN(DurationSeconds) AS Minimum,
       MAX(DurationSeconds) AS Maximum
FROM Incidents
GROUP BY Shape
-- Return records where minimum of DurationSeconds is greater than 1
HAVING MIN(DurationSeconds) > 1;

-- Return the specified columns
SELECT IncidentDateTime, IncidentState
FROM Incidents
-- Exclude all the missing values from IncidentState
WHERE IncidentState IS NOT NULL;

-- Check the IncidentState column for missing values and replace them with the City column
SELECT IncidentState, ISNULL(IncidentState, City) AS Location
FROM Incidents
-- Filter to only return missing values from IncidentState
WHERE IncidentState IS NULL;

-- Replace missing values
-- COALESCE returns the first non NULL value of the variables inside the parenthesis
SELECT Country, COALESCE(Country, IncidentState, City) AS Location
FROM Incidents
WHERE Country IS NULL;

SELECT Country,
       CASE WHEN Country = 'us'  THEN 'USA'
       ELSE 'International'
       END AS SourceCountry
FROM Incidents;

-- Complete the syntax for cutting the duration into different cases
SELECT DurationSeconds,
-- Start with the 2 TSQL keywords, and after the condition a TSQL word and a value
      CASE WHEN (DurationSeconds <= 120) THEN 1
-- The pattern repeats with the same keyword and after the condition the same word and next value
       WHEN (DurationSeconds > 120 AND DurationSeconds <= 600) THEN 2
-- Use the same syntax here
       WHEN (DurationSeconds > 601 AND DurationSeconds <= 1200) THEN 3
-- Use the same syntax here
       WHEN (DurationSeconds > 1201 AND DurationSeconds <= 5000) THEN 4
-- Specify a value
       ELSE 5
       END AS SecondGroup
FROM Incidents;

-- Write a query that returns an aggregation
SELECT MixDesc, SUM(Quantity) AS Total
FROM Shipments
-- Group by the relevant column
GROUP BY MixDesc;

-- Count the number of rows by MixDesc
SELECT MixDesc, COUNT(*)
FROM Shipments
GROUP BY MixDesc;

-- Return the difference in OrderDate and ShipDate
SELECT OrderDate, ShipDate,
       DATEDIFF(DD, OrderDate, ShipDate) AS Duration
FROM Shipments;

-- Return the DeliveryDate as 5 days after the ShipDate
SELECT OrderDate,
       DATEADD(DD, 5, ShipDate) AS DeliveryDate
FROM Shipments;

-- Round Cost to the nearest dollar
SELECT Cost,
       ROUND(Cost, 0) AS RoundedCost
FROM Shipments;

-- Truncate cost to whole number
SELECT Cost,
       ROUND(Cost, 0, 1) AS TruncateCost
FROM Shipments;

-- Return the absolute value of DeliveryWeight
SELECT DeliveryWeight,
       ABS(DeliveryWeight) AS AbsoluteValue
FROM Shipments;

-- Return the square and square root of WeightValue
SELECT WeightValue,
       SQUARE(WeightValue) AS WeightSquare,
       SQRT(WeightValue) AS WeightSqrt
FROM Shipments;

-- Declare the variable (a SQL Command, the var name, the datatype)
DECLARE @counter INT

-- Set the counter to 20
SET @counter = 20

-- Select and increment the counter by one
SET @counter = @counter +1

-- Print the variable
SELECT @counter;



DECLARE @counter INT
SET @counter = 20

-- Create a loop
WHILE @counter < 30

-- Loop code starting point
BEGIN
	SELECT @counter = @counter + 1
-- Loop finish
END

-- Check the value of the variable
SELECT @counter;

-- Derived tables
SELECT a.RecordId, a.Age, a.BloodGlucoseRandom,
-- Select maximum glucose value (use colname from derived table)
       b.MaxGlucose
FROM Kidney a
-- Join to derived table
JOIN (SELECT Age, MAX(BloodGlucoseRandom) AS MaxGlucose FROM Kidney GROUP BY Age) b
-- Join on Age
ON a.Age = b.Age;