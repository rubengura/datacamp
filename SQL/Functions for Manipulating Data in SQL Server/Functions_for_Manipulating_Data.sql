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