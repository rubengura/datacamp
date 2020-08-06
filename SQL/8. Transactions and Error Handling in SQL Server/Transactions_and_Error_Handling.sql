-- LESSON 1
-- Set up the TRY block
BEGIN TRY
	-- Add the constraint
	ALTER TABLE products
		ADD CONSTRAINT CHK_Stock CHECK (stock >= 0);
END TRY
-- Set up the CATCH block
BEGIN CATCH
	SELECT 'An error occurred!';
END CATCH

-- Set up the first TRY block
BEGIN TRY
	INSERT INTO buyers (first_name, last_name, email, phone)
		VALUES ('Peter', 'Thompson', 'peterthomson@mail.com', '555000100');
END TRY
-- Set up the first CATCH block
BEGIN CATCH
	SELECT 'An error occurred inserting the buyer! You are in the first CATCH block';
    -- Set up the nested TRY block
    BEGIN TRY
    	INSERT INTO errors
        	VALUES ('Error inserting a buyer');
        SELECT 'Error inserted correctly!';
	END TRY
    -- Set up the nested CATCH block
    BEGIN CATCH
    	SELECT 'An error occurred inserting the error! You are in the nested CATCH block';
    END CATCH
END CATCH

BEGIN TRY
	INSERT INTO products (product_name, stock, price)
		VALUES ('Sun Bicycles ElectroLite - 2017', 10, 1559.99);
END TRY
BEGIN CATCH
	SELECT 'An error occurred inserting the product!';
    BEGIN TRY
    	INSERT INTO errors
        	VALUES ('Error inserting a product');
    END TRY
    BEGIN CATCH
    	SELECT 'An error occurred inserting the error!';
    END CATCH
END CATCH

-- Set up the TRY block
BEGIN TRY
	SELECT 'Total: ' + SUM(price * quantity) AS total
	FROM orders
END TRY
-- Set up the CATCH block
BEGIN CATCH
	-- Show error information.
	SELECT  ERROR_NUMBER() AS number,
        	ERROR_SEVERITY() AS severity_level,
        	ERROR_STATE() AS state,
        	ERROR_LINE() AS line,
        	ERROR_MESSAGE() AS message;
END CATCH

BEGIN TRY
    INSERT INTO products (product_name, stock, price)
    VALUES	('Trek Powerfly 5 - 2018', 2, 3499.99),
    		('New Power K- 2018', 3, 1999.99)
END TRY
-- Set up the outer CATCH block
BEGIN CATCH
	SELECT 'An error occurred inserting the product!';
    -- Set up the inner TRY block
    BEGIN TRY
    	-- Insert the error
    	INSERT INTO errors
        	VALUES ('Error inserting a product');
    END TRY
    -- Set up the inner CATCH block
    BEGIN CATCH
    	-- Show number and message error
    	SELECT
        	ERROR_LINE() AS line,
			ERROR_MESSAGE() AS message;
    END CATCH
END CATCH

-- LESSON 2
-- CATCHING the RAISERROR
BEGIN TRY
    DECLARE @product_id INT = 5;
    IF NOT EXISTS (SELECT * FROM products WHERE product_id = @product_id)
        RAISERROR('No product with id %d.', 11, 1, @product_id);
    ELSE
        SELECT * FROM products WHERE product_id = @product_id;
END TRY
-- Catch the error
BEGIN CATCH
	-- Select the error message
	SELECT ERROR_MESSAGE();
END CATCH


-- THROW
CREATE PROCEDURE insert_product
  @product_name VARCHAR(50),
  @stock INT,
  @price DECIMAL

AS

BEGIN TRY
	INSERT INTO products (product_name, stock, price)
		VALUES (@product_name, @stock, @price);
END TRY
-- Set up the CATCH block
BEGIN CATCH
	-- Insert the error and end the statement with a semicolon
    INSERT INTO errors VALUES ('Error inserting a product');
    -- Re-throw the error
	THROW;
END CATCH


BEGIN TRY
	-- Execute the stored procedure
	EXEC insert_product
    	-- Set the values for the parameters
    	@product_name = 'Super bike',
        @stock = 3,
        @price = 499.99;
END TRY
-- Set up the CATCH block
BEGIN CATCH
	-- Select the error message
	SELECT ERROR_MESSAGE();
END CATCH

-- Set @staff_id to 4
DECLARE @staff_id INT = 4;

IF NOT EXISTS (SELECT * FROM staff WHERE staff_id = @staff_id)
   	-- Invoke the THROW statement with parameters
	THROW 50001, 'No staff member with such id', 1;
ELSE
   	SELECT * FROM staff WHERE staff_id = @staff_id


-- Set @first_name to 'Pedro'
DECLARE @first_name NVARCHAR(20) = 'Pedro';
-- Concat the message
DECLARE @my_message NVARCHAR(500) =
	FORMATMESSAGE('There is no staff member with ', @first_name, ' as the first name.');

IF NOT EXISTS (SELECT * FROM staff WHERE first_name = @first_name)
	-- Throw the error
	THROW 50000, @my_message, 1;


DECLARE @product_name AS NVARCHAR(50) = 'Trek CrossRip+ - 2018';
DECLARE @number_of_sold_bikes AS INT = 10;
DECLARE @current_stock INT;
-- Select the current stock
SELECT @current_stock = stock FROM products WHERE product_name = @product_name;
DECLARE @my_message NVARCHAR(500) =
	-- Customize the message
	FORMATMESSAGE('There are not enough %s bikes. You only have %d in stock.', @product_name, @current_stock);

IF (@current_stock - @number_of_sold_bikes < 0)
	-- Throw the error
	THROW 50000, @my_message, 1;


-- Pass the variables to the stored procedure
EXEC sp_addmessage @msgnum = 50002, @severity = 16, @msgtext = 'There are not enough %s bikes. You only have %d in stock.', @lang = N'us_english';

DECLARE @product_name AS NVARCHAR(50) = 'Trek CrossRip+ - 2018';
DECLARE @number_of_sold_bikes AS INT = 10;
DECLARE @current_stock INT;
SELECT @current_stock = stock FROM products WHERE product_name = @product_name;
DECLARE @my_message NVARCHAR(500) =
	-- Prepare the error message
	FORMATMESSAGE(50002, @product_name, @current_stock);

IF (@current_stock - @number_of_sold_bikes < 0)
	-- Throw the error
	THROW 50000, @my_message, 1;