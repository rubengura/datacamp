-- LESSON 1
SELECT
	company,
	company_location,
	bean_origin,
	cocoa_percent,
	rating
FROM ratings
-- Location should be Belgium and the rating should exceed 3.5
WHERE company_location = 'Belgium'
	AND rating > 3.5;

SELECT
	first_name,
	last_name,
	birthdate,
	gender,
	email,
	country,
	total_votes
FROM voters
-- Birthdate > 1990-01-01, total_votes > 100 but < 200
WHERE birthdate > '1990-01-01'
  AND total_votes > 100
  AND total_votes < 200;

ALTER TABLE voters
ADD last_vote_date date;

ALTER TABLE voters
ADD last_vote_time time;

ALTER TABLE voters
ADD last_login datetime2;

-- CAST()
SELECT
	-- Transform the year part from the birthdate to a string
	first_name + ' ' + last_name + ' was born in ' + CAST(YEAR(birthdate) AS nvarchar) + '.'
FROM voters;

SELECT
	-- Transform to int the division of total_votes to 5.5
	CAST(total_votes / 5.5 AS INT) AS DividedVotes
FROM voters;

SELECT
	first_name,
	last_name,
	total_votes
FROM voters
-- Transform the total_votes to char of length 10
WHERE CAST(total_votes AS varchar(10)) LIKE '5%';

-- CONVERT()
SELECT
	email,
    -- Convert birthdate to varchar show it like: "Mon dd,yyyy"
    CONVERT(varchar, birthdate, 107) AS birthdate
FROM voters;

SELECT
	company,
    bean_origin,
    -- Convert the rating column to an integer
    CONVERT(INT, rating) AS rating
FROM ratings;

SELECT
	company,
    bean_origin,
    rating
FROM ratings
-- Convert the rating to an integer before comparison
WHERE CONVERT(int, rating) = 3;

SELECT
	first_name,
    last_name,
	-- Convert birthdate to varchar(10) to show it as yy/mm/dd
	CONVERT(varchar(10), birthdate, 11) AS birthdate,
    gender,
    country,
    -- Convert the total_votes number to nvarchar
    'Voted ' + CAST(total_votes AS nvarchar) + ' times.' AS comments
FROM voters
WHERE country = 'Belgium'
    -- Select only the female voters
	AND gender = 'F'
    -- Select only people who voted more than 20 times
    AND total_votes > 20;


-- LESSON 2
-- Manipulating Time
-- Most common date function for retrieving current date:
SELECT
	SYSDATETIME() AS CurrentDate;

-- Select the current date in UTC time (Universal Time Coordinate)
-- using two different functions.
SELECT
	CURRENT_TIMESTAMP AS UTC_HighPrecision,
	GETUTCDATE() AS UTC_LowPrecision;

-- Select the local system's date, including the timezone information.
SELECT
	GETDATE() AS Timezone;

-- Use two functions to query the system's local date, without timezone
-- information. Show the dates in different formats.
SELECT
	CONVERT(VARCHAR(24), SYSDATETIME(), 107) AS HighPrecision,
	CONVERT(VARCHAR(24), SYSDATETIME(), 102) AS LowPrecision;

-- Use two functions to retrieve the current time, in Universal Time Coordinate.
SELECT
	CAST(SYSUTCDATETIME() AS time) AS HighPrecision,
	CAST(SYSUTCDATETIME() AS time) AS LowPrecision;

-- Extracting parts of a date
SELECT
	first_name,
	last_name,
	-- Extract the year of the first vote
	YEAR(first_vote_date)  AS first_vote_year,
    -- Extract the month of the first vote
	MONTH(first_vote_date) AS first_vote_month,
    -- Extract the day of the first vote
	DAY(first_vote_date)   AS first_vote_day
FROM voters
-- The year of the first vote should be greater than 2015
WHERE YEAR(first_vote_date) > 2015
-- The day should not be the first day of the month
  AND DAY(first_vote_date) <> 1;

-- Generating descriptive date parts
SELECT
	first_name,
	last_name,
	first_vote_date,
    -- Select the name of the month of the first vote
	DATENAME(MONTH, first_vote_date) AS first_vote_month
FROM voters;


SELECT
	first_name,
	last_name,
	first_vote_date,
    -- Select the number of the day within the year
	DATENAME(DAYOFYEAR, first_vote_date) AS first_vote_dayofyear
FROM voters;

SELECT
	first_name,
	last_name,
	first_vote_date,
    -- Select day of the week from the first vote date
	DATENAME(WEEKDAY, first_vote_date) AS first_vote_dayofweek
FROM voters;


SELECT
	first_name,
	last_name,
   	-- Extract the month number of the first vote
	DATEPART(MONTH,first_vote_date) AS first_vote_month1,
	-- Extract the month name of the first vote
    DATENAME(MONTH,first_vote_date) AS first_vote_month2,
	-- Extract the weekday number of the first vote
	DATEPART(WEEKDAY,first_vote_date) AS first_vote_weekday1,
    -- Extract the weekday name of the first vote
	DATENAME(WEEKDAY,first_vote_date) AS first_vote_weekday2
FROM voters;

SELECT
	first_name,
	last_name,
    -- Select the year of the first vote
   	YEAR(first_vote_date) AS first_vote_year,
    -- Select the month of the first vote
	MONTH(first_vote_date) AS first_vote_month,
    -- Create a date as the start of the month of the first vote
	DATEFROMPARTS(YEAR(first_vote_date), MONTH(first_vote_date), 1) AS first_vote_starting_month
FROM voters;


-- Performing arithmetic operations on dates
SELECT
	first_name,
	birthdate,
    -- Add 18 years to the birthdate
	DATEADD(YEAR, 18, birthdate) AS eighteenth_birthday
  FROM voters;

SELECT
	first_name,
	first_vote_date,
    -- Add 5 days to the first voting date
	DATEADD(DAY, 5, first_vote_date) AS processing_vote_date
  FROM voters;

SELECT
	-- Subtract 476 days from the current date
	DATEADD(DAY, -476, SYSDATETIME()) AS date_476days_ago;


SELECT
	first_name,
	birthdate,
	first_vote_date,
    -- Select the diff between the 18th birthday and first vote
	DATEDIFF(YEAR, DATEADD(YEAR, 18, birthdate), first_vote_date) AS adult_years_until_vote
FROM voters;

SELECT
	-- Get the difference in weeks from 2019-01-01 until now
	DATEDIFF(WEEK, '2019-01-01', SYSDATETIME()) AS weeks_passed;


-- Validating if expression is a date
DECLARE @date1 NVARCHAR(20) = '2018-30-12';

-- Set the date format and check if the variable is a date
SET DATEFORMAT ydm;
SELECT ISDATE(@date1) AS result;


DECLARE @date1 NVARCHAR(20) = '15/2019/4';

-- Set the date format and check if the variable is a date
SET DATEFORMAT dym;
SELECT ISDATE(@date1) AS result;

DECLARE @date1 NVARCHAR(20) = '10.13.2019';

-- Set the date format and check if the variable is a date
SET DATEFORMAT mdy;
SELECT ISDATE(@date1) AS result;

DECLARE @date1 NVARCHAR(20) = '18.4.2019';

-- Set the date format and check if the variable is a date
SET DATEFORMAT dmy;
SELECT ISDATE(@date1) AS result;


-- Language	 Date format
-- English	    mdy
-- Croatian	    ymd
-- Dutch	    dmy

DECLARE @date1 NVARCHAR(20) = '30.03.2019';

-- Set the correct language
SET LANGUAGE 'Dutch';
SELECT
	@date1 AS initial_date,
    -- Check that the date is valid
	ISDATE(@date1) AS is_valid,
    -- Select the name of the month
	DATENAME(MONTH, @date1) AS month_name;

DECLARE @date1 NVARCHAR(20) = '32/12/13';

-- Set the correct language
SET LANGUAGE 'Croatian';
SELECT
	@date1 AS initial_date,
    -- Check that the date is valid
	ISDATE(@date1) AS is_valid,
    -- Select the name of the month
	DATENAME(MONTH, @date1) AS month_name,
	-- Extract the year from the date
	YEAR(@date1) AS year_name;

DECLARE @date1 NVARCHAR(20) = '12/18/55';

-- Set the correct language
SET LANGUAGE English;
SELECT
	@date1 AS initial_date,
    -- Check that the date is valid
	ISDATE(@date1) AS is_valid,
    -- Select the week day name
	DATENAME(WEEKDAY, @date1) AS week_day,
	-- Extract the year from the date
	YEAR(@date1) AS year_name;

SELECT
	first_name,
    last_name,
    birthdate,
	first_vote_date,
	-- Find out on which day of the week each participant voted
	DATENAME(weekday, first_vote_date) AS first_vote_weekday,
	-- Find out the year of the first vote
	YEAR(first_vote_date) AS first_vote_year,
	-- Discover the participants' age when they joined the contest
	DATEDIFF(YEAR, birthdate, first_vote_date) AS age_at_first_vote,
	-- Calculate the current age of each voter
	DATEDIFF(YEAR, birthdate, SYSDATETIME()) AS current_age
FROM voters;

-- LESSON 3
-- Working with Strings
SELECT TOP 10
	company,
	broad_bean_origin,
	-- Calculate the length of the broad_bean_origin column
	LEN(broad_bean_origin) AS length
FROM ratings
--Order the results based on the new column, descending
ORDER BY length DESC;

SELECT
	first_name,
	last_name,
	email
FROM voters
-- Look for the "dan" expression in the first_name
WHERE CHARINDEX('dan', first_name) > 0
    -- Look for last_names that do not contain the letter "z"
	AND CHARINDEX('z', last_name) = 0;

SELECT
	first_name,
	last_name,
	email
FROM voters
-- Look for first names that start with C and the 3rd letter is r
WHERE PATINDEX('C_r%', first_name) > 0;


SELECT
	first_name,
	last_name,
	email
FROM voters
-- Look for first names that have an "a" followed by 0 or more letters and then have a "w"
WHERE PATINDEX('%a%w%', first_name) > 0;

SELECT
	first_name,
	last_name,
	email
FROM voters
-- Look for first names that contain one of the letters: "x", "w", "q"
WHERE PATINDEX('%[xwq]%', first_name) > 0;


SELECT
	company,
	bean_type,
	broad_bean_origin,
    -- 'company' and 'broad_bean_origin' should be in uppercase
	'The company ' +  UPPER(company) + ' uses beans of type "' + bean_type + '", originating from ' + UPPER(broad_bean_origin) + '.'
FROM ratings
WHERE
    -- The 'broad_bean_origin' should not be unknown
	LOWER(broad_bean_origin) NOT LIKE '%unknown%'
     -- The 'bean_type' should not be unknown
    AND LOWER(bean_type) NOT LIKE '%unknown%';


SELECT
	first_name,
	last_name,
	country,
    -- Select only the first 3 characters from the first name
	LEFT(first_name, 3) AS part1,
    -- Select only the last 3 characters from the last name
    RIGHT(last_name, 3) AS part2,
    -- Select only the last 2 digits from the birth date
    RIGHT(birthdate, 2) AS part3,
    -- Create the alias for each voter
    LEFT(first_name, 3) + RIGHT(last_name, 3) + '_' + RIGHT(birthdate, 2)
FROM voters;


SELECT
	email,
    -- Extract 5 characters from email, starting at position 3
	SUBSTRING(email, 3, 5) AS some_letters
FROM voters;

DECLARE @sentence NVARCHAR(200) = 'Apples are neither oranges nor potatoes.'
SELECT
	-- Extract the word "Apples"
	SUBSTRING(@sentence, 1, 6) AS fruit1,
    -- Extract the word "oranges"
	SUBSTRING(@sentence, 20, 7) AS fruit2;


SELECT
	first_name,
	last_name,
	email,
	-- Replace "yahoo.com" with "live.com"
	REPLACE(email, 'yahoo.com', 'live.com') AS new_email
FROM voters;

SELECT
	company AS initial_name,
    -- Replace '&' with 'and'
	REPLACE(company, '&', 'and') AS new_name
FROM ratings
WHERE CHARINDEX('&', company) > 0;

SELECT
	company AS old_company,
    -- Remove the text '(Valrhona)' from the name
	REPLACE(company, '(Valrhona)', '') AS new_company,
	bean_type,
	broad_bean_origin
FROM ratings
WHERE company = 'La Maison du Chocolat (Valrhona)';

-- Concatenating Data
DECLARE @string1 NVARCHAR(100) = 'Chocolate with beans from';
DECLARE @string2 NVARCHAR(100) = 'has a cocoa percentage of';

SELECT
	bean_type,
	bean_origin,
	cocoa_percent,
	-- Create a message by concatenating values with "+"
	@string1 + ' ' + bean_origin + ' ' + @string2 + ' ' + CAST(cocoa_percent AS nvarchar) AS message1,
	-- Create a message by concatenating values with "CONCAT()"
	CONCAT(@string1, ' ', bean_origin, ' ', @string2, ' ', cocoa_percent) AS message2,
	-- Create a message by concatenating values with "CONCAT_WS()"
	CONCAT_WS(' ', @string1, bean_origin, @string2, cocoa_percent) AS message3
FROM ratings
WHERE
	company = 'Ambrosia'
	AND bean_type <> 'Unknown';

SELECT
	company,
    -- Create a list with all bean origins ordered alphabetically
	STRING_AGG(bean_origin, ',') WITHIN GROUP (ORDER BY bean_origin) AS bean_origins
FROM ratings
WHERE company IN ('Bar Au Chocolat', 'Chocolate Con Amor', 'East Van Roasters')
-- Specify the columns used for grouping your data
GROUP BY company;

-- company	bean_origins
-- Bar Au Chocolat	Bahia,Chiapas,Duarte Province,Maranon Canyon,Sambirano
-- Chocolate Con Amor	Dominican Republic,Dominican Republic,Ecuador,Nicaragua,Ocumare,Uganda,Wild Bolivian
-- East Van Roasters	Dominican Republic,Madagascar,Peru

DECLARE @phrase NVARCHAR(MAX) = 'In the morning I brush my teeth. In the afternoon I take a nap. In the evening I watch TV.'

SELECT value
FROM STRING_SPLIT(@phrase, '.');

DECLARE @phrase NVARCHAR(MAX) = 'In the morning I brush my teeth. In the afternoon I take a nap. In the evening I watch TV.'

SELECT value
FROM STRING_SPLIT(@phrase, ' ');


SELECT
    -- Concatenate the first and last name
	CONCAT('***' , first_name, ' ', UPPER(last_name), '***') AS name,
    -- Mask the last two digits of the year
    REPLACE(birthdate, SUBSTRING(CAST(birthdate AS varchar), 3, 2), 'XX') AS birthdate,
	email,
	country
FROM voters
   -- Select only voters with a first name less than 5 characters
WHERE LEN(first_name) < 5
   -- Look for this pattern in the email address: "j%[0-9]@yahoo.com"
	AND PATINDEX('j_a%@yahoo.com', email) > 0;

-- name	                birthdate	email	            country
-- ***Juan ROMERO***	19XX-03-15	juan1@yahoo.com	    Germany
-- ***Joan ROSS***	    19XX-06-22	joan8@yahoo.com	    Switzerland
-- ***Joan MARTIN***	19XX-03-26	joan19@yahoo.com	Spain


-- LESSON 4
-- Aggregations
SELECT
	gender,
	-- Count the number of voters for each group
	COUNT(*) AS voters,
	-- Calculate the total number of votes per group
	SUM(total_votes) AS total_votes
FROM voters
GROUP BY gender;

SELECT
	company,
	-- Calculate the average cocoa percent
	AVG(cocoa_percent) AS avg_cocoa,
	-- Calculate the minimum rating received by each company
	MIN(rating) AS min_rating,
	-- Calculate the maximum rating received by each company
	MAX(rating) AS max_rating
FROM ratings
GROUP BY company
-- Order the values by the maximum rating
ORDER BY MAX(rating) DESC;

-- Analytical functions
SELECT
	first_name,
	last_name,
	total_votes AS votes,
    -- Select the number of votes of the next voter
	LEAD(total_votes) OVER (ORDER BY total_votes) AS votes_next_voter,
    -- Calculate the difference between the number of votes
	LEAD(total_votes) OVER (ORDER BY total_votes) - total_votes AS votes_diff
FROM voters
WHERE country = 'France'
ORDER BY total_votes;

SELECT
	broad_bean_origin AS bean_origin,
	rating,
	cocoa_percent,
    -- Retrieve the cocoa % of the bar with the previous rating
	LAG(cocoa_percent)
		OVER(PARTITION BY broad_bean_origin ORDER BY rating) AS percent_lower_rating
FROM ratings
WHERE company = 'Fruition'
ORDER BY broad_bean_origin, rating ASC;

SELECT
	first_name + ' ' + last_name AS name,
	country,
	birthdate,
	-- Retrieve the birthdate of the oldest voter per country
	FIRST_VALUE(birthdate)
	OVER (PARTITION BY country ORDER BY birthdate) AS oldest_voter,
	-- Retrieve the birthdate of the youngest voter per country
	LAST_VALUE(birthdate)
		OVER (PARTITION BY country ORDER BY birthdate ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
				) AS youngest_voter
FROM voters
WHERE country IN ('Spain', 'USA');

-- Mathematical Functions
DECLARE @number1 DECIMAL(18,2) = -5.4;
DECLARE @number2 DECIMAL(18,2) = 7.89;
DECLARE @number3 DECIMAL(18,2) = 13.2;
DECLARE @number4 DECIMAL(18,2) = 0.003;

DECLARE @result DECIMAL(18,2) = @number1 * @number2 - @number3 - @number4;
SELECT
	@result AS result,
	-- Show the absolute value of the result
	ABS(@result) AS abs_result,
	-- Find the sign of the result
	SIGN(@result) AS sign_result;

SELECT
	rating,
	-- Round-up the rating to an integer value
	CEILING(rating) AS round_up,
	-- Round-down the rating to an integer value
	FLOOR(rating) AS round_down,
	-- Round the rating value to one decimal
	ROUND(rating, 1) AS round_onedec,
	-- Round the rating value to two decimals
	ROUND(rating, 2) AS round_twodec
FROM ratings;

DECLARE @number DECIMAL(4, 2) = 4.5;
DECLARE @power INT = 4;

SELECT
	@number AS number,
	@power AS power,
	-- Raise the @number to the @power
	POWER(@number, @power) AS number_to_power,
	-- Calculate the square of the @number
	SQUARE(@number) num_squared,
	-- Calculate the square root of the @number
	SQRT(@number) num_square_root;

SELECT
	company,
    -- Select the number of cocoa flavors for each company
	COUNT(*) AS flavors,
    -- Select the minimum, maximum and average rating
	MIN(rating) AS lowest_score,
	MAX(rating) AS highest_score,
	AVG(rating) AS avg_score,
    -- Round the average rating to 1 decimal
    ROUND(AVG(rating), 1) AS round_avg_score,
    -- Round up and then down the aveg. rating to the next integer
    CEILING(AVG(rating)) AS round_up_avg_score,
	FLOOR(AVG(rating)) AS round_down_avg_score
FROM ratings
GROUP BY company
ORDER BY flavors DESC;