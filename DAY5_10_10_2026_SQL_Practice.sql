USE MyFirstDB;
GO

CREATE TABLE dbo.Day6Customers
(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);
GO

CREATE TABLE dbo.Day6Orders
(
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT
);
GO

INSERT INTO dbo.Day6Customers
    (customer_id, customer_name, city)
VALUES
    (1, 'Priya', 'Kolkata'),
    (2, 'Rahul', 'Delhi'),
    (3, 'Amit', 'Kolkata'),
    (4, 'Neha', 'Mumbai');

    INSERT INTO dbo.Day6Orders
    (order_id, order_date, customer_id)
VALUES
    (101, '2026-10-01', 1),
    (102, '2026-10-02', 2),
    (103, '2026-10-03', 3),
    (104, '2026-10-04', 1),
    (105, '2026-10-05', 4);

    SELECT *
FROM dbo.Day6Customers;

SELECT *
FROM dbo.Day6Orders;

/*Q1. Using Day6Customers and Day6Orders, write a subquery to display the order_id, order_date, 
and customer_id for orders placed by customers who live in Delhi.
Sort the results by order_date in descending order.*/

SELECT * FROM [Day6Orders]
WHERE [customer_id] IN(
SELECT [customer_id] FROM [Day6Customers]
WHERE [city]='Delhi'
)ORDER BY [order_date] DESC;

SELECT [product_name],[price] FROM [Day4Products]
WHERE [price] >(
SELECT AVG([price]) FROM [Day4Products]
);
/*Q2. Write a query to display the product_name and price of products 
whose price is less than the average price of all products.*/

SELECT [product_name] , [price] FROM [Day4Products] WHERE [price] < (SELECT
AVG([price]) FROM [Day4Products]);

----Nested Subquery------

SELECT [order_id],[order_date],[customer_id] FROM [Day6Orders]
WHERE [customer_id] IN (
SELECT [customer_id] FROM [Day6Customers] WHERE
[city] = (
SELECT [city] FROM [Day6Customers] WHERE [customer_name] = 'Priya'
)
) ORDER BY [order_date] DESC;

/* Q3. Using your existing Day6Customers and Day6Orders tables, 
write a nested subquery to display order_id, order_date, 
and customer_id for all orders placed by customers living in the same city as Rahul.
Sort the results by order_date in descending order.*/

SELECT * FROM [Day6Orders] WHERE [customer_id] IN (
SELECT [customer_id] FROM [Day6Customers] WHERE [city] =(
SELECT [city] FROM [Day6Customers] WHERE [customer_name] = 'Rahul'
)
) ORDER BY [order_date] DESC;


SELECT [product_name],[price] FROM [Day4Products] WHERE[price] > ANY
(
SELECT [price] FROM [Day4Products] WHERE [category] = 'Wood'
);

SELECT * FROM [Day4Products];

/*Q4. Write a query to display product_name and price for products whose price is less than at least 
one price in the Interior category, using  < ANY with a subquery.*/

SELECT [product_name],[price] FROM [Day4Products] WHERE [price] <= ANY (
SELECT [price] FROM [Day4Products] WHERE [category] = 'Interior'
);
/* Q5. Using Day4Products, write a query to display product_name and price for products whose price is 
greater than every price in the Interior category, using > ALL with a subquery.*/

SELECT [product_name],[price] FROM [Day4Products] WHERE [price] > ALL (
SELECT [price] FROM [Day4Products] WHERE [category] = 'Interior');


SELECT [c].[customer_id] ,[c].[customer_name] FROM [Day6Customers] AS [c]  WHERE EXISTS 
( SELECT 1
FROM [Day6Orders]AS [o] WHERE [o].[customer_id] = [c].[customer_id]
);

/* Q6. Write a query using NOT EXISTS to display the customer_id, customer_name, 
and city of customers who have not placed any orders.*/

SELECT [c].[customer_id],[c].[customer_name],[c].[city] FROM [Day6Customers] AS [c] WHERE
NOT EXISTS (
SELECT 1 FROM [Day6Orders] AS [o] WHERE [c].[customer_id] = [o].[customer_id]);

SELECT AVG([order_count]) AS [average_order_count] FROM (
SELECT [customer_id] , COUNT(*) AS [order_count] FROM [Day6Orders] GROUP BY [customer_id]) AS [t];

SELECT
    [customer_id],
    COUNT(*) AS [order_count]
FROM [Day6Orders]
GROUP BY [customer_id];

SELECT MAX([t].[order_count]) AS [maximum_order_count] FROM (
SELECT [customer_id] , COUNT(*) AS [order_count] FROM [Day6Orders] 
GROUP BY [customer_id]
) AS [t];

SELECT
    [p1].[product_name],
    [p1].[category],
    [p1].[price]
FROM [Day4Products] AS [p1]
WHERE [p1].[price] IN
(
    SELECT MAX([p2].[price])
    FROM [Day4Products] AS [p2]
    WHERE [p2].[category] = [p1].[category]
    GROUP BY [p2].[category]
);
/* Using Day6Customers and Day6Orders, write a query with EXISTS and a 
correlated subquery to find customers who have placed at least two orders.*/

SELECT [c].[customer_id] , [c].[customer_name] FROM [Day6Customers] AS [c]
WHERE EXISTS (
SELECT COUNT(*) 
FROM [Day6Orders] AS [o] 
WHERE [c].[customer_id] = [o].[customer_id] GROUP BY [o].[customer_id] HAVING COUNT(*) >=2
);

SELECT * FROM [Day6Orders];
