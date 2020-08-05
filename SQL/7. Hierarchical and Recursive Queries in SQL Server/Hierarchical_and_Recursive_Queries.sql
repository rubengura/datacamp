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

-- Create the alphabet recursively
WITH alphabet AS (
	SELECT
  		-- Initialize letter to A
	    65 AS number_of_letter
	-- Statement to combine the anchor and the recursive query
  	UNION ALL
	SELECT
  		-- Add 1 each iteration
	    number_of_letter + 1
  	-- Select from the defined CTE alphabet
	FROM alphabet
  	-- Limit the alphabet to A-Z
  	WHERE number_of_letter < 90)

SELECT char(number_of_letter)
FROM alphabet;

-- Create time series of a year
WITH time_series AS (
	SELECT
  		-- Get the current time
	    GETDATE() AS time
  	UNION ALL
	SELECT
	    DATEADD(day, 1, time)
  	-- Call the CTE recursively
	FROM time_series
  	-- Limit the time series to 1 year minus 1 (365 days -1)
  	WHERE time < GETDATE() + 364);

SELECT time
FROM time_series;
-- Increase the number of iterations (365 days)
OPTION(MAXRECURSION 365);


-- Create the CTE employee_hierarchy
WITH employee_hierarchy AS (
	SELECT
		ID,
  		NAME,
  		Supervisor
	FROM employee
  	-- Start with the IT Director
	WHERE Supervisor = 0
	UNION ALL
	SELECT
  		emp.ID,
  		emp.NAME,
  		emp.Supervisor
	FROM employee emp
  		JOIN employee_hierarchy
  		ON emp.Supervisor = employee_hierarchy.ID)

SELECT
    cte.Name as EmployeeName,
    emp.Name as ManagerName
FROM employee_hierarchy as cte
	JOIN employee as emp
	-- Perform the JOIN on Supervisor and ID
	ON cte.Supervisor = emp.ID;


WITH employee_hierarchy AS (
	SELECT
		ID,
  		NAME,
  		Supervisor,
  		-- Initialize the field LEVEL
  		1 as LEVEL
	FROM employee
  	-- Start with the supervisor ID of the IT Director
	WHERE Supervisor = 0
	UNION ALL
	SELECT
  		emp.ID,
  		emp.NAME,
  		emp.Supervisor,
  		-- Increment LEVEL by 1 each step
  		LEVEL + 1
	FROM employee emp
		JOIN employee_hierarchy
  		-- JOIN on supervisor and ID
  		ON emp.Supervisor = employee_hierarchy.ID)

SELECT
	cte.Name, cte.Level,
    emp.Name as ManagerID
FROM employee_hierarchy as cte
	JOIN employee as emp
	ON cte.Supervisor = emp.ID
ORDER BY Level;

WITH employee_Hierarchy AS (
	SELECT
		ID,
  		NAME,
  		Supervisor,
  		-- Initialize the Path with CAST
  		CAST('0' AS VARCHAR(MAX)) as Path
	FROM employee
	WHERE Supervisor = 0
	-- UNION the anchor query
  	UNION ALL
    -- Select the recursive query fields
	SELECT
  		emp.ID,
  		emp.NAME,
  		emp.Supervisor,
  		-- Add the supervisor in each step. CAST the supervisor.
        Path + '->' + CAST(emp.Supervisor AS VARCHAR(MAX))
	FROM employee emp
		INNER JOIN employee_Hierarchy
  		ON emp.Supervisor = employee_Hierarchy.ID
)

SELECT Path
FROM employee_Hierarchy
-- Select the employees Christian Feierabend and Jasmin Mentil
WHERE ID = 16 OR ID = 18;



WITH children AS (
    SELECT
  		ID,
  		Name,
  		ParentID,
  		0 as LEVEL
  	FROM family
  	-- Set the targeted parent as recursion start
  	WHERE ParentID = 101
    UNION ALL
    SELECT
  		child.ID,
  		child.NAME,
  		child.ParentID,
  		-- Increment LEVEL by 1 each step
  		LEVEL + 1
  	FROM family child
  		INNER JOIN children
		-- Join the anchor query with the CTE
  		ON child.ParentID = children.ID)

SELECT
	-- Count the number of generations
	COUNT(*) as Generations
FROM children
OPTION(MAXRECURSION 300);

WITH tree AS (
	SELECT
  		ID,
  		Name,
  		ParentID,
  		CAST('0' AS VARCHAR(MAX)) as Parent
	FROM family
  	-- Initialize the ParentID to 290
  	WHERE ParentID = 290
    UNION ALL
    SELECT
  		Next.ID,
  		Next.Name,
  		Parent.ID,
    	CAST(CASE WHEN Parent.ID = ''
        	      -- Set the Parent field to the current ParentID
                  THEN(CAST(Next.ParentID AS VARCHAR(MAX)))
        	 -- Add the ParentID to the current Parent in each iteration
             ELSE(Parent.Parent + ' -> ' + CAST(Next.ParentID AS VARCHAR(MAX)))
    		 END AS VARCHAR(MAX))
        FROM family AS Next
        	INNER JOIN tree AS Parent
  			ON Next.ParentID = Parent.ID)

-- Select the Name, Parent from tree
SELECT Name, Parent
FROM tree;
