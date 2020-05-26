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