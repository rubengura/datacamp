-- LESSON 2
-- Data schema normalization
-- EXERCISES
--Adding foreign keys
ALTER TABLE fact_booksales ADD CONSTRAINT sales_book
    FOREIGN KEY (book_id) REFERENCES dim_book_star (book_id);

ALTER TABLE fact_booksales ADD CONSTRAINT sales_time
    FOREIGN KEY (time_id) REFERENCES dim_time_star (time_id);

ALTER TABLE fact_booksales ADD CONSTRAINT sales_store
    FOREIGN KEY (store_id) REFERENCES dim_store_star (store_id);

-- Create dim_author with an author column
CREATE TABLE dim_author (
    author VARCHAR(256)  NOT NULL
);

-- Insert authors into the new table
INSERT INTO dim_author
SELECT DISTINCT author FROM dim_book_star;

-- Add a primary key
ALTER TABLE dim_author ADD COLUMN author_id SERIAL PRIMARY KEY;

-- Selecting data from a denormalized database:
-- Total sales amount per state on novels
SELECT dim_store_star.state, SUM(sales_amount)
FROM fact_booksales
    JOIN dim_book_star on fact_booksales.book_id = dim_book_star.book_id
    JOIN dim_store_star on fact_booksales.store_id = dim_store_star.store_id
WHERE
    dim_book_star.genre = 'novel'
GROUP BY
    dim_store_star.state;


-- Same query as above with normalized database
SELECT dim_state_sf.state, SUM(sales_amount)
FROM fact_booksales
    JOIN dim_book_sf on fact_booksales.book_id = dim_book_sf.book_id
    JOIN dim_genre_sf on dim_book_sf.genre_id = dim_genre_sf.genre_id
    JOIN dim_store_sf on fact_booksales.store_id = dim_store_sf.store_id
    JOIN dim_city_sf on dim_store_sf.city_id = dim_city_sf.city_id
	JOIN dim_state_sf on  dim_city_sf.state_id = dim_state_sf.state_id
WHERE
    dim_genre_sf.genre = 'novel'
GROUP BY
    dim_state_sf.state;

-- Extending snowflake schema
-- Adding a continent_id column with default value of 1
ALTER TABLE dim_country_sf
ADD continent_id int NOT NULL DEFAULT(1);

-- Adding foreign key constraint
ALTER TABLE dim_country_sf ADD CONSTRAINT country_continent
   FOREIGN KEY (continent_id) REFERENCES dim_continent_sf(continent_id);

-- LESSON 3 --
-- Database Views
-- Exercises
-- Selecting avialable views
SELECT * FROM information_schema.views
WHERE table_schema NOT IN ('pg_catalog', 'information_schema');

-- Querying a view
CREATE VIEW high_scores AS
SELECT * FROM reviews
WHERE score > 9;

SELECT COUNT(*) FROM high_scores
INNER JOIN labels ON high_scores.reviewid = labels.reviewid
WHERE label = 'self-released';

-- Managing views
CREATE VIEW top_artists_2017 AS
SELECT artist_title.artist FROM artist_title
INNER JOIN top_15_2017
ON artist_title.reviewid = top_15_2017.reviewid;

-- Dropping both views (top_15_2017 and top_artist_2019)
DROP VIEW top_15_2017 CASCADE;

REVOKE UPDATE, INSERT ON long_reviews FROM PUBLIC;
GRANT UPDATE, INSERT ON long_reviews TO editor;

-- Materialized views
CREATE MATERIALIZED VIEW genre_count AS
SELECT genre, COUNT(*)
FROM genres
GROUP BY genre;

INSERT INTO genres
VALUES (50000, 'classical');

REFRESH MATERIALIZED VIEW genre_count;

-- LESSON 4 --
-- THEORY
-- Creating roles
CREATE ROLE data_analyst;
CREATE ROLE intern WITH PASSWORD 'ABCD1234' VALID UNTIL '2020-01-01';

-- Granting and revoking privileges
-- GRANT ACTION [, ACTION] ON table TO user;
GRANT UPDATE, DELETE ON ratings TO data_analyst;
REVOKE UPDATE ON ratings FROM data_analyst;

-- Granting and revoking group privileges to user
GRANT data_analyst TO intern;

-- EXERCISES
-- Creating roles
CREATE ROLE data_scientist;
CREATE ROLE marta LOGIN;
CREATE ROLE admin WITH CREATEDB CREATEROLE;

-- Granting and altering privileges
GRANT UPDATE, INSERT ON long_reviews TO data_scientist;
ALTER ROLE marta WITH PASSWORD 's3cur3p@ssw0rd';

-- Granting and revoking group access to users
GRANT data_scientist TO marta;
REVOKE data_scientist FROM marta;

-- THEORY
-- Table partitioning
CREATE TABLE sales (
    ...
    timestamp DATE NOT NULL
)
PARTITION BY RANGE (timestamp);

CREATE TABLE sales_2019_q1 PARTITION OF sales
    FOR VALUES FROM ('2019-01-01') TO ('2019-03-31');

CREATE TABLE sales_2019_q4 PARTITION OF sales
    FOR VALUES FROM ('2019-09-01') TO ('2019-12-31');

-- EXERCISES
-- Vertical partitioning
CREATE TABLE film_descriptions (
    film_id INT,
    long_description TEXT
);
INSERT INTO film_descriptions
SELECT film_id, long_description FROM film;
ALTER TABLE film DROP long_description;
SELECT * FROM film
JOIN film_descriptions
ON film.film_id = film_descriptions.film_id;

-- Horizontal partitioning
CREATE TABLE film_partitioned (
  film_id INT,
  title TEXT NOT NULL,
  release_year TEXT
)
PARTITION BY LIST (release_year);

CREATE TABLE film_2019
	PARTITION OF film_partitioned FOR VALUES IN ('2019');

CREATE TABLE film_2018
	PARTITION OF film_partitioned FOR VALUES IN ('2018');

CREATE TABLE film_2017
	PARTITION OF film_partitioned FOR VALUES IN ('2017');

INSERT INTO film_partitioned
SELECT film_id, title, release_year FROM film;

SELECT * FROM film_partitioned;
