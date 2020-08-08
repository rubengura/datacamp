-- LESSON 1
-- Creating Triggers
-- Create a new trigger that fires when deleting data
CREATE TRIGGER PreventDiscountsDelete
ON Discounts
-- The trigger should fire instead of DELETE
INSTEAD OF DELETE
AS
	PRINT 'You are not allowed to delete data from the Discounts table.';

-- Set up a new trigger
CREATE TRIGGER OrdersUpdatedRows
ON Orders
-- The trigger should fire after UPDATE statements
AFTER UPDATE
-- Add the AS keyword before the trigger body
AS
	-- Insert details about the changes to a dedicated table
	INSERT INTO OrdersUpdate(OrderID, OrderDate, ModifyDate)
	SELECT OrderID, OrderDate, GETDATE()
	FROM inserted;

-- Create a new trigger
CREATE TRIGGER ProductsNewItems
ON Products
AFTER INSERT
AS
	-- Add details to the history table
	INSERT INTO ProductsHistory(Product, Price, Currency, FirstAdded)
	SELECT Product, Price, Currency, GETDATE()
	FROM inserted;


-- Run an update for some of the discounts
UPDATE Discounts
SET Discount = Discount + 1
WHERE Discount <= 5;

-- Verify the trigger ran successfully
SELECT * FROM DiscountsHistory;


-- Add the following rows to the table
INSERT INTO SalesWithPrice (Customer, Product, Price, Currency, Quantity)
VALUES ('Fruit Mag', 'Pomelo', 1.12, 'USD', 200),
	   ('VitaFruit', 'Avocado', 2.67, 'USD', 400),
	   ('Tasty Fruits', 'Blackcurrant', 2.32, 'USD', 1100),
	   ('Health Mag', 'Kiwi', 1.42, 'USD', 100),
	   ('eShop', 'Plum', 1.1, 'USD', 500);

-- Verify the results after adding the new rows
SELECT * FROM SalesWithPrice;

--OrderID	Customer	Product	Price	Currency	Quantity	OrderDate	TotalAmount
--26	Fruit Mag	Pomelo	1.12	USD	200	2020-08-08	224.00
--27	VitaFruit	Avocado	2.67	USD	400	2020-08-08	1068.00
--28	Tasty Fruits	Blackcurrant	2.32	USD	1100	2020-08-08	2552.00
--29	Health Mag	Kiwi	1.42	USD	100	2020-08-08	142.00
--30	eShop	Plum	1.10	USD	500	2020-08-08	550.00


-- Add the following rows to the table
INSERT INTO SalesWithoutPrice (Customer, Product, Currency, Quantity)
VALUES ('Fruit Mag', 'Pomelo', 'USD', 200),
	   ('VitaFruit', 'Avocado', 'USD', 400),
	   ('Tasty Fruits', 'Blackcurrant', 'USD', 1100),
	   ('Health Mag', 'Kiwi', 'USD', 100),
	   ('eShop', 'Plum', 'USD', 500);

-- Verify the results after the INSERT
SELECT * FROM SalesWithoutPrice;

--OrderID	Customer	Product	Quantity	OrderDate	TotalAmount	Currency
--26	Fruit Mag	Pomelo	200	2020-08-08	240.00	USD
--27	VitaFruit	Avocado	400	2020-08-08	1200.00	USD
--28	Tasty Fruits	Blackcurrant	1100	2020-08-08	2750.00	USD
--29	Health Mag	Kiwi	100	2020-08-08	140.00	USD
--30	eShop	Plum	500	2020-08-08	600.00	USD