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

-- LESSON 3
-- Creating a table
-- Define the table Person
CREATE TABLE Person (
  	-- Define the Individual ID
  	IndividualID INT NOT NULL,
  	-- Set Firstname and Lastname not to be NULL of type VARCHAR(255)
	Firstname VARCHAR(255) NOT NULL,
	Lastname VARCHAR(255) NOT NULL,
	Address VARCHAR(255) NOT NULL,
  	City CHAR(32) NOT NULL,
   	-- Define Birthday as DATE
  	Birthday DATE
);

SELECT *
FROM Person;


INSERT INTO Person
VALUES ('1','Andrew','Anderson','Union Ave 10','New York','1986-12-30');
INSERT INTO Person
VALUES ('2','Peter','Jackson','342 Flushing st','New York','1986-12-30');

-- Set the person's first name to Jones for ID = 1
UPDATE Person
SET Firstname = 'Jones'
WHERE ID = 1;

-- Update the birthday of the person with the last name Jackson
UPDATE Person
SET Birthday = '1980-01-05'
WHERE Lastname = 'Jackson';

SELECT *
FROM Person;


INSERT INTO Person
VALUES ( '1', 'Andrew', 'Anderson', 'Address 1', 'City 1', '1986-12-30');
INSERT INTO Person
VALUES ( '2', 'Peter', 'Jackson', 'Address 2', 'City 2', '1986-12-30');
INSERT INTO Person
VALUES ( '3', 'Michaela', 'James', 'Address 3', 'City 3', '1976-03-07');

DELETE FROM Person
WHERE ID = 1;
DELETE FROM Person
WHERE Lastname = 'Jackson';

-- Drop the table Person
DROP TABLE Person

SELECT *
FROM Person;

-- Add the column Email to Person
ALTER TABLE Person
ADD Email VARCHAR(255);

-- Delete the column Birthday of Person
ALTER TABLE Person
DROP COLUMN Birthday;

-- Check the table definition
SELECT *
FROM Person;

CREATE TABLE Person (
  	-- Define the primary key for Person of type INT
  	PersonID INT NOT NULL PRIMARY KEY,
	Firstname VARCHAR(255) NOT NULL,
	Lastname VARCHAR(255) NOT NULL,
);

CREATE TABLE History (
    -- Define the primary key for History
  	OrderID INT NOT NULL PRIMARY KEY,
    Item VARCHAR(255) NOT NULL,
    Price INT NOT NULL,
  	-- Define the foreign key for History
    PersonID INT FOREIGN KEY REFERENCES Person(PersonID)
);

SELECT *
FROM History;

-- Insert new data into the table Person
INSERT INTO Person
VALUES ('1','Andrew','Anderson','Union Ave 10','New York','1986-12-30');
INSERT INTO Person
VALUES ('2', 'Sam', 'Smith','Flushing Ave 342','New York','1986-12-30');

-- Insert new data into the table History
INSERT INTO History
VALUES ('1','IPhone XS', 1000,'1');
INSERT INTO History
VALUES ('2','MacBook Pro','1800', '2');

SELECT *
FROM History;

INSERT INTO Person
VALUES ('1', 'Andrew', 'Anderson','Union Ave 10','New York','1986-12-30');
INSERT INTO Person
VALUES ('2', 'Sam', 'Smith','Flushing Ave 342','New York','1986-12-30');

INSERT INTO History VALUES ( '1', 'IPhone XS', '1000', '1');
INSERT INTO History VALUES ( '2', 'MacBook Pro', '1800', '1');
INSERT INTO History VALUES ( '5', 'IPhone XR', '600', '2');
INSERT INTO History VALUES ( '6', 'IWatch 4', '400', '1');

SELECT
    Person.ID,
    -- Count the number of orders
    COUNT(*) as Orders,
    -- Add the total price of all orders
    SUM(Price) as Costs
FROM Person
	-- Join the tables Person and History on their IDs
	JOIN History
	ON Person.ID = History.PersonID
-- Aggregate the information on the ID
GROUP BY Person.ID;

CREATE TABLE Equipment (
    -- Define ID and ParentID
	ID INT NOT NULL,
    Equipment VARCHAR(255) NOT NULL,
    ParentID INT
);

INSERT INTO Equipment VALUES ('1','Asset',NULL);
INSERT INTO Equipment VALUES ('2','Hardware','1');
-- Insert the type Software
INSERT INTO Equipment VALUES ('3','Software','1');
INSERT INTO Equipment VALUES ('4','Application','3');
INSERT INTO Equipment VALUES ('5','Tool','3');
INSERT INTO Equipment VALUES ('6','PC','2');
-- Insert the type Monitor
INSERT INTO Equipment VALUES ('7','Monitor','2');
INSERT INTO Equipment VALUES ('8','Phone','2');
INSERT INTO Equipment VALUES ('9','IPhone','8');
-- Insert the type Microsoft Office
INSERT INTO Equipment VALUES ('10','Microsoft Office','4');

SELECT *
FROM Equipment;

CREATE TABLE Trip (
    -- Define the Departure
  	Departure VARCHAR(255) NOT NULL,
    BusName VARCHAR(255) NOT NULL,
    -- Define the Destination
    Destination VARCHAR(255) NOT NULL,
);

-- Insert a route from San Francisco to New York
INSERT INTO Trip VALUES ( 'San Francisco' , 'Bus 1' , 'New York');
-- Insert a route from Florida to San Francisco
INSERT INTO Trip VALUES ( 'Florida', 'Bus 9','San Francisco');
INSERT INTO Trip VALUES ( 'San Francisco', 'Bus 2','Texas');
INSERT INTO Trip VALUES ( 'San Francisco', 'Bus 3','Florida');
INSERT INTO Trip VALUES ( 'San Francisco', 'Bus 4','Washington');
INSERT INTO Trip VALUES ( 'New York', 'Bus 5','Texas');
INSERT INTO Trip VALUES ( 'New York', 'Bus 6','Washington');
INSERT INTO Trip VALUES ( 'Florida', 'Bus 7','New York');
INSERT INTO Trip VALUES ( 'Florida', 'Bus 8','Toronto');

-- Get all possible departure locations
SELECT DISTINCT(Departure)
FROM Trip;

-- LESSON 4
-- Practical example
-- Definition of the CTE table
WITH possible_Airports (Airports) AS(
  	-- Select the departure airports
  	SELECT Departure
  	FROM flightPlan
  	-- Combine the two queries
  	UNION
  	-- Select the destination airports
  	SELECT Arrival
  	FROM flightPlan)

-- Get the airports from the CTE table
SELECT Airports
FROM possible_Airports;


-- Define totalCost
WITH flight_route (Departure, Arrival, stops, totalCost, route) AS(
	SELECT
	  	f.Departure, f.Arrival,
	  	0,
	  	-- Define the totalCost with the flight cost of the first flight
	  	f.Cost as totalCost,
	  	CAST(Departure + ' -> ' + Arrival AS NVARCHAR(MAX))
	FROM flightPlan f
	WHERE Departure = 'Vienna'
	UNION ALL
	SELECT
	  	p.Departure, f.Arrival,
	  	p.stops + 1,
	  	-- Add the cost for each layover to the total costs
	  	p.totalCost + f.Cost,
	  	p.route + ' -> ' + f.Arrival
	FROM flightPlan f, flight_route p
	WHERE p.Arrival = f.Departure AND
	      p.stops < 5)

SELECT
	DISTINCT Arrival,
    totalCost
FROM flight_route
-- Limit the total costs to 500
WHERE totalCost < 500;


-- Car example
CREATE TABLE Bill_Of_Material (
	-- Define PartID as primary key of type INT
  	PartID INT NOT NULL PRIMARY KEY,
	SubPartID INT,
	Component VARCHAR(255) NOT NULL,
	Title  VARCHAR(255) NOT NULL,
	Vendor VARCHAR(255) NOT NULL,
  	ProductKey CHAR(32) NOT NULL,
  	-- Define Cost of type INT and NOT NULL
  	Cost INT NOT NULL,
	Quantity INT NOT NULL);

-- Insert the root element SUV as described
INSERT INTO Bill_Of_Material
VALUES ('1',NULL,'SUV','BMW X1','BMW','F48',50000,1);
INSERT INTO Bill_Of_Material
VALUES ('2','1','Engine','V6BiTurbro','BMW','EV3891ASF',3000,1);
INSERT INTO Bill_Of_Material
VALUES ('3','1','Body','AL_Race_Body','BMW','BD39281PUO',5000,1);
INSERT INTO Bill_Of_Material
VALUES ('4','1','Interior Decoration','All_Leather_Brown','BMW','ZEU198292',2500,1);
-- Insert the entry Wheels as described
INSERT INTO Bill_Of_Material
VALUES ('5','1','Wheels','M-Performance 19/255','BMW','MKQ134098URZ',400,4);

SELECT *
FROM Bill_Of_Material;


-- Define CTE with the fields: PartID, SubPartID, Title, Component, Level
WITH construction_Plan (PartID, SubPartID, Title, Component, Level) AS (
	SELECT
  		PartID,
  		SubPartID,
  		Title,
  		Component,
  		-- Initialize the field Level
  		1 AS Level
	FROM partList
	WHERE PartID = '1'
	UNION ALL
	SELECT
		CHILD.PartID,
  		CHILD.SubPartID,
  		CHILD.Title,
  		CHILD.Component,
  		-- Increment the field Level each recursion step
  		PARENT.Level + 1
	FROM construction_Plan PARENT, partList CHILD
  	WHERE CHILD.SubPartID = PARENT.PartID
  	-- Limit the number of iterations to Level < 2
	  AND PARENT.Level < 2)

SELECT DISTINCT PartID, SubPartID, Title, Component, Level
FROM construction_Plan
ORDER BY PartID, SubPartID, Level;

-- Define CTE with the fields: PartID, SubPartID, Level, Component, Total
WITH construction_Plan (PartID, SubPartID, Level, Component, Total) AS (
	SELECT
  		PartID,SubPartID,
  		0,
  		Component,
  		-- Initialize Total
  		Quantity AS Total
 	FROM partList
	WHERE PartID = '1'
	UNION ALL
	SELECT
		CHILD.PartID, CHILD.SubPartID,
  		PARENT.Level + 1,
  		CHILD.Component,
  		-- Increase Total by the quantity of the child element
  		PARENT.Total + CHILD.Quantity
	FROM construction_Plan PARENT, partList CHILD
  	WHERE CHILD.SubPartID = PARENT.PartID
	  AND PARENT.Level < 3)

SELECT
    PartID, SubPartID,Component,
    -- Calculate the sum of total on the aggregated information
    SUM(Total)
FROM construction_Plan
GROUP BY PartID, SubPartID, Component
ORDER BY PartID, SubPartID;

-- Power Grid
-- Create the table
CREATE TABLE structure (
    -- Define the field EquipmentID
  	EqupmentID INT NOT NULL PRIMARY KEY,
    EquipmentID_To INT ,
    EquipmentID_From INT,
    VoltageLevel TEXT NOT NULL,
    Description TEXT NOT NULL,
    ConstructionYear INT NOT NULL,
    InspectionYear INT NOT NULL,
    ConditionAssessment TEXT NOT NULL
);

-- Insert the record for line 1 as described
INSERT INTO structure
VALUES ( 1, 2, NULL, 'HV', 'Cable', 2000, 2016, 'good');
INSERT INTO Structure
VALUES ( 2, 3 , 1, 'HV', 'Overhead Line', 1968, 2016, 'bad');
INSERT INTO Structure
VALUES ( 3, 14, 2, 'HV', 'TRANSFORMER', 1972, 2001, 'good');
-- Insert the record for line 14 as described
INSERT INTO Structure
VALUES ( 14, 15, 3 , 'MV', 'Cable', 1976, 2002, 'bad');

SELECT *
FROM structure;

-- Define the table CTE
WITH maintenance_List (Line, Destination, Source, Description, ConditionAssessment, VoltageLevel) AS (
	SELECT
  		EquipmentID,
  		EquipmentID_To,
  		EquipmentID_From,
  		Description,
  		ConditionAssessment,
  		VoltageLevel
  	FROM GridStructure
 	-- Start the evaluation for line 3
	WHERE EquipmentID = 3
	UNION ALL
	SELECT
		Child.EquipmentID,
  		Child.EquipmentID_To,
  		Child.EquipmentID_FROM,
  		Child.Description,
  		Child.ConditionAssessment,
  		Child.VoltageLevel
	FROM GridStructure Child
  		-- Join GridStructure with CTE on the corresponding endpoints
  		JOIN maintenance_List
    	ON maintenance_List.Line = Child.EquipmentID_FROM)
SELECT Line, Description, ConditionAssessment
FROM maintenance_List
-- Filter the lines based on ConditionAssessment and VoltageLevel
WHERE
    (ConditionAssessment LIKE '%exchange%' OR ConditionAssessment LIKE '%repair%') AND
     VoltageLevel LIKE '%HV%'