-- LESSON 1
-- Define the CTE ITjobs by the WITH operator
WITH ITjobs (ID, Name, Position) AS (
    SELECT
  		ID,
  		Name,
  		Position
    FROM employee
    -- Find IT jobs and names starting with A
  	WHERE Position LIKE 'IT%' AND Name LIKE 'A%')

SELECT *
FROM ITjobs;


WITH ITjobs (ID, Name, Position) AS (
    SELECT
  		ID,
  		Name,
  		Position
    FROM employee
    WHERE Position like 'IT%'),

-- Define the second CTE table ITSalary with the fields ID and Salary
ITSalary (ID, Salary) AS (
    SELECT
        ID,
        Salary
    FROM Salary
  	-- Find salaries above 3000
    WHERE Salary > 3000)

SELECT
	ITjobs.NAME,
	ITjobs.POSITION,
    ITsalary.Salary
FROM ITjobs
    -- Combine the two CTE tables the correct join variant
    INNER JOIN ITsalary
    -- Execute the join on the ID of the tables
    ON ITjobs.ID = ITsalary.ID;


-- Define the target factorial number
DECLARE @target float = 5
-- Initialization of the factorial result
DECLARE @factorial float = 1

WHILE @target > 0
BEGIN
	-- Calculate the factorial number
	SET @factorial = @factorial * @target
	-- Reduce the termination condition
	SET @target = @target - 1
END

SELECT @factorial;

WITH calculate_factorial AS (
	SELECT
		-- Initialize step and the factorial number
      	1 AS step,
        1 AS factorial
	UNION ALL
	SELECT
	 	step + 1,
		-- Calculate the recursive part by n!*(n+1)
	    factorial * (step + 1)
	FROM calculate_factorial
	-- Stop the recursion reaching the wanted factorial number
	WHERE step < 6)

SELECT factorial
FROM calculate_factorial;

-- Counting numbers recuersively
-- Define the CTE
WITH counting_numbers AS (
	SELECT
  		-- Initialize number
  		1 AS number
  	UNION ALL
  	SELECT
  		-- Increment number by 1
  		number = number + 1
  	FROM counting_numbers
	-- Set the termination condition
  	WHERE number < 50)

SELECT number
FROM counting_numbers;

-- Calculate sum of potencies
-- Define the CTE calculate_potencies with the fields step and result
WITH calculate_potencies (step, result) AS (
    SELECT
  		-- Initialize step and result
  		1,
  		1
    UNION ALL
    SELECT
  		step + 1,
  		-- Add the POWER calculation to the result
  		result + POWER(step + 1, step + 1)
    FROM calculate_potencies
    WHERE step < 9)

SELECT
	step,
    result
FROM calculate_potencies;