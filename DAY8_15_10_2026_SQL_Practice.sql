USE MyFirstDB;
GO

CREATE TABLE dbo.Day8UDFOrderItems
(
    item_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    quantity INT,
    list_price DECIMAL(10,2),
    discount DECIMAL(4,2)
);
GO

INSERT INTO dbo.Day8UDFOrderItems
    (item_id, product_name, quantity, list_price, discount)
VALUES
    (1, 'Laptop', 2, 50000.00, 0.10),
    (2, 'Keyboard', 3, 1500.00, 0.05),
    (3, 'Mouse', 4, 800.00, 0.00),
    (4, 'Monitor', 2, 12000.00, 0.15),
    (5, 'Headphones', 1, 2500.00, 0.20);

    SELECT *
FROM dbo.Day8UDFOrderItems;
--------------USER DEFIND FUNCTION--------------
CREATE FUNCTION [dbo].[Day8NetSale](
@quantity INT,
@list_price DECIMAL(10,2),
@discount DECIMAL(4,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN 
RETURN @quantity * @list_price*(1-@discount);
END;

SELECT [dbo].[Day8NetSale](2,50000,0.10) AS net_sale;

SELECT [dbo].[Day8NetSale](3,1500,0.05) AS [net_sale];

SELECT [product_name],[quantity],[list_price],[discount],
[dbo].[Day8NetSale](
[quantity],[list_price],[discount])
AS [net_sale] FROM [Day8UDFOrderItems];

----------------------------

SELECT [product_name], [dbo].[Day8NetSale] ([quantity],[list_price],[discount]) AS [net_sale]
FROM [Day8UDFOrderItems] WHERE [dbo].[Day8NetSale]([quantity],[list_price],[discount])>5000;

/* Write a query to display product_name and net_sale for products whose 
calculated net sale is greater than ₹3,000. 
Use your dbo.Day8NetSale function in the WHERE clause.*/

SELECT [product_name], [dbo].[Day8NetSale]([quantity],[list_price],[discount]) AS [net_sale] FROM
[Day8UDFOrderItems] WHERE
[dbo].[Day8NetSale]([quantity],[list_price],[discount]) >3000;

-------------------TABLE VALUED FUNCTION-------------------

CREATE FUNCTION [Day8ProductsAbovePrice](
@MinimumPrice DECIMAL(10,2)
)RETURNS TABLE
AS
RETURN (
SELECT * FROM [Day8UDFOrderItems]
WHERE [list_price] >@MinimumPrice
);

SELECT * FROM [Day8ProductsAbovePrice] (10000);

SELECT * FROM [Day8ProductsAbovePrice](2000);

--------------MULTI STATEMENT TABLE VALUED FUNCTION----------------
CREATE FUNCTION [Day8ProductsAbovePrice_Multi](
@MinimumPrice DECIMAL(10,2)
)
RETURNS @product TABLE(
[list_id] INT,
[product_name] VARCHAR(10),
[quantity] INT,
[list_price] DECIMAL(10,2),
[discount] DECIMAL(4,2)
)
AS
BEGIN
INSERT INTO @product
SELECT * FROM [Day8UDFOrderItems] WHERE [list_price]>@MinimumPrice;
RETURN;
END;

SELECT * FROM [Day8ProductsAbovePrice_Multi] (10000);

SELECT * FROM [Day8ProductsAbovePrice](2000);

SELECT * FROM Employee;

USE MyFirstDB;
GO

CREATE TABLE [Day8Department]
(
    [id] INT PRIMARY KEY,
    [dept_name] NVARCHAR(50)
);
GO

CREATE TABLE [Day8Employee]
(
    [id] INT PRIMARY KEY,
    [emp_name] NVARCHAR(50),
    [gender] NVARCHAR(10),
    [salary] INT,
    [dept_id] INT FOREIGN KEY REFERENCES [Day8Department](Id)
);
GO

INSERT INTO [Day8Department] ([id] ,[dept_name])
VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Payroll'),
(4, 'Administration'),
(5, 'Sales');

INSERT INTO [Day8Employee] ([id], [emp_name], [gender], [salary], [dept_id])
VALUES
(1, 'Mark', 'Male', 50000, 1),
(2, 'Mary', 'Female', 60000, 3),
(3, 'Steve', 'Male', 45000, 2),
(4, 'John', 'Male', 56000, 1),
(5, 'Sara', 'Female', 39000, 2);

SELECT * FROM [Day8Employee];
SELECT * FROM [Day8Department];

CREATE FUNCTION [return_gender](
@gender VARCHAR(10)
)RETURNS TABLE
AS RETURN(
SELECT * FROM [Day8Employee] WHERE [gender] = @gender
);
SELECT * FROM [return_gender]('Male');

SELECT e.[emp_name], e.[gender], d.[dept_name] FROM [return_gender]('Male') AS e INNER JOIN 
[Day8Department] AS d ON d.[id]=e.[dept_id];

SELECT [e].[emp_name],[e].[gender],[d].[dept_name] FROM [return_gender]('Female') AS [e]
INNER JOIN [Day8Department] as [d] ON [d].[id] = [e].[dept_id];

-- Modify an existing function
ALTER FUNCTION [Day8NetSale]
(
    @quantity INT,
    @list_price DECIMAL(10,2),
    @discount DECIMAL(4,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @quantity * @list_price * (1 - @discount);
END;
GO

DROP FUNCTION [Day8NetSale];