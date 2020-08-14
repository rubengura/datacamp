-- LESSON 1

-- Query the right table in information_schema
SELECT table_name
FROM information_schema.tables
-- Specify the correct table_schema value
WHERE table_schema = 'public';

-- Query the right table in information_schema to get columns
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'university_professors' AND table_schema = 'public';

-- Query the first five rows of our table
SELECT *
FROM university_professors
LIMIT 5;

-- Create a table for the professors entity type
CREATE TABLE professors (
 firstname text,
 lastname text
);

-- Print the contents of this table
SELECT *
FROM professors

-- Create a table for the universities entity type
CREATE TABLE universities (
university_shortname text,
university text,
university_city text
);


-- Print the contents of this table
SELECT *
FROM universities;

-- Add the university_shortname column
ALTER TABLE professors
ADD COLUMN university_shortname text;

-- Print the contents of this table
SELECT *
FROM professors

-- Rename the organisation column
ALTER TABLE affiliations
RENAME COLUMN organisation TO organization;

-- Delete the university_shortname column
ALTER TABLE affiliations
DROP COLUMN university_shortname;

-- Insert unique professors into the new table
INSERT INTO professors
    SELECT DISTINCT firstname, lastname, university_shortname
    FROM university_professors;

-- Doublecheck the contents of professors
SELECT *
FROM professors;

-- Insert unique affiliations into the new table
INSERT INTO affiliations
SELECT DISTINCT firstname, lastname, function, organization
FROM university_professors;

-- Doublecheck the contents of affiliations
SELECT *
FROM affiliations;

-- Delete the university_professors table
DROP TABLE university_professors;

-- LESSON 2

-- Let's add a record to the table
INSERT INTO transactions (transaction_date, amount, fee)
VALUES ('2018-24-09', 5454, '30');

-- Doublecheck the contents
SELECT *
FROM transactions;

-- Calculate the net amount as amount + fee
SELECT transaction_date, amount + CAST(fee AS integer) AS net_amount
FROM transactions;

-- Select the university_shortname column
SELECT DISTINCT(university_shortname)
FROM professors;

-- Specify the correct fixed-length character type
ALTER TABLE professors
ALTER COLUMN university_shortname
TYPE char(3);

-- Change the type of firstname
ALTER TABLE professors
ALTER COLUMN firstname
TYPE varchar(64);

-- Convert the values in firstname to a max. of 16 characters
ALTER TABLE professors
ALTER COLUMN firstname
TYPE varchar(16)
USING SUBSTRING(firstname FROM 1 FOR 16)

-- Disallow NULL values in firstname
ALTER TABLE professors
ALTER COLUMN firstname SET NOT NULL;

-- Disallow NULL values in lastname
ALTER TABLE professors
ALTER COLUMN lastname
SET NOT NULL;

-- Make universities.university_shortname unique
ALTER TABLE universities
ADD CONSTRAINT university_shortname_unq UNIQUE(university_shortname);

-- Make organizations.organization unique
ALTER TABLE organizations
ADD CONSTRAINT organization_unq UNIQUE(organization);