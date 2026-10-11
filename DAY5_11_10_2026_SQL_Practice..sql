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

SELECT
    [order_id],
    [order_date],
    [customer_id]
FROM [Day6Orders]
WHERE [customer_id] IN
(
    SELECT [customer_id]
    FROM [Day6Customers]
    WHERE [city] = 'Kolkata'
)
ORDER BY [order_date] DESC;


SELECT [product_name], [price]
FROM [Day4Products]
WHERE [price] >
(
    SELECT AVG([price])
    FROM [Day4Products]
);
/*Q2. Write a query to display the product_name and price of products whose price 
is less than the average price of all products.*/

SELECT [product_name], [price]
FROM [Day4Products]
WHERE [price] <
(
    SELECT AVG([price])
    FROM [Day4Products]
);

-- NESTED subquery
SELECT [order_id], [order_date], [customer_id]
FROM [Day6Orders]
WHERE [customer_id] IN (
    SELECT [customer_id]
    FROM [Day6Customers]
    WHERE [city] = (
        SELECT [city]
        FROM [Day6Customers]
        WHERE [customer_name] = 'Priya'
    )
)
ORDER BY [order_date] DESC;

--Any operater

SELECT [product_name], [price]
FROM [Day4Products]
WHERE [price] > ANY
(
    SELECT [price]
    FROM [Day4Products]
    WHERE [category] = 'Wood'
);
-- ALL operatoer
SELECT [product_name], [price]
FROM [Day4Products]
WHERE [price] > ALL
(
    SELECT [price]
    FROM [Day4Products]
    WHERE [category] = 'Interior'
);

--- EXISTS 
SELECT
    c.customer_id,
    c.customer_name
FROM [Day6Customers] AS c
WHERE EXISTS
(
    SELECT 1
    FROM [Day6Orders] AS o
    WHERE o.customer_id = c.customer_id
);

-- NOT Exists
SELECT
    c.customer_id,
    c.customer_name
FROM [Day6Customers] AS c
WHERE NOT EXISTS
(
    SELECT 1
    FROM [Day6Orders] AS o
    WHERE o.customer_id = c.customer_id
);
-- FROM clause

SELECT
    [customer_id],
    COUNT(*) AS [order_count]
FROM [Day6Orders]
GROUP BY [customer_id];

SELECT AVG([order_count]) AS [average_order_count]
FROM
(
    SELECT
        [customer_id],
        COUNT(*) AS [order_count]
    FROM [Day6Orders]
    GROUP BY [customer_id]
) AS [t];

/* Using Day6Customers and Day6Orders, write a query with EXISTS to 
display all orders placed by customers who live in Mumbai.*/

SELECT * FROM [Day6Orders] AS [o]
WHERE EXISTS(
SELECT [c].[customer_id] FROM [Day6Customers] AS [c] WHERE [c].[customer_id]=[o].[customer_id] 
AND [c].[city]='Mumbai'
);

--Correlated subquery

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

---------------------------------

SELECT [o].[order_id],
[o].[order_date],
[c].[customer_name],
[c].[city] FROM [Day6Orders] AS [o]
INNER JOIN [Day6Customers] AS [c] 
ON [c].[customer_id] =[o].[customer_id]
WHERE [c].[city]='Mumbai';

/* Using the same two tables, write a query with INNER JOIN to display the order_id, customer_name,
and city for orders placed by customers living in Kolkata. */
SELECT [o].[order_id],
[c].[customer_name],
[c].[city] FROM [Day6Orders] AS [o]
INNER JOIN [Day6Customers] AS [c]
ON [c].[customer_id] = [o].[customer_id]
WHERE [c].[city]='Kolkata';

-----------------------------------

USE MyFirstDB;
GO

CREATE TABLE dbo.Day6Departments
(
    Id INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);
GO

CREATE TABLE dbo.Day6Employees
(
    Id INT PRIMARY KEY,
    Name VARCHAR(50),
    Gender VARCHAR(10),
    Salary INT,
    DepartmentId INT,
    FOREIGN KEY (DepartmentId)
        REFERENCES dbo.Day6Departments(Id)
);
GO

INSERT INTO dbo.Day6Departments
    (Id, DepartmentName)
VALUES
    (1, 'IT'),
    (2, 'HR'),
    (3, 'Payroll'),
    (4, 'Administration'),
    (5, 'Sales');

    INSERT INTO dbo.Day6Employees
    (Id, Name, Gender, Salary, DepartmentId)
VALUES
    (1, 'Mark',  'Male',   50000, 1),
    (2, 'Mary',  'Female', 60000, 3),
    (3, 'Steve', 'Male',   45000, 2),
    (4, 'John',  'Male',   56000, 1),
    (5, 'Sara',  'Female', 39000, 2);

    SELECT * FROM dbo.Day6Departments;
SELECT * FROM dbo.Day6Employees;
----------------------------

CREATE FUNCTION dbo.return_dept_id
(
@DepartmentID INT
) RETURNS TABLE AS
RETURN (
SELECT * FROM [Day6Employees] WHERE [DepartmentId] = @DepartmentID
);
GO

SELECT * FROM dbo.return_dept_id(2);

SELECT [d].[DepartmentName],
[e].[Name],
[e].[Gender],
[e].[Salary] FROM [dbo].[Day6Departments] AS [d] 
CROSS APPLY  dbo.return_dept_id([d].[Id]) AS [e];
----------------------------------------------
SELECT [d].[DepartmentName],
[e].[Name],[e].[Gender],[e].[Salary] 
FROM [Day6Departments] AS [d]
OUTER APPLY dbo.return_dept_id([d].[Id]) AS [e];

----------------------------------------------

USE MyFirstDB;
GO

CREATE TABLE dbo.Day6CustomerUpdateDemo
(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    age INT,
    salary DECIMAL(10,2)
);
GO

CREATE TABLE dbo.Day6CustomerBackupDemo
(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    age INT,
    salary DECIMAL(10,2)
);
GO

INSERT INTO dbo.Day6CustomerUpdateDemo
    (customer_id, customer_name, age, salary)
VALUES
    (1, 'Priya', 24, 30000),
    (2, 'Rahul', 27, 40000),
    (3, 'Amit', 30, 45000),
    (4, 'Neha', 25, 35000),
    (5, 'Sara', 32, 50000);

INSERT INTO dbo.Day6CustomerBackupDemo
    (customer_id, customer_name, age, salary)
VALUES
    (1, 'Priya', 24, 30000),
    (2, 'Rahul', 27, 40000),
    (3, 'Amit', 30, 45000),
    (4, 'Neha', 25, 35000),
    (5, 'Sara', 32, 50000);

    SELECT * FROM dbo.Day6CustomerUpdateDemo;
SELECT * FROM dbo.Day6CustomerBackupDemo;
--------------------------------------------------

UPDATE [dbo].[Day6CustomerUpdateDemo]
SET [salary] *=0.25
WHERE [age] IN (
SELECT [age] FROM [dbo].[Day6CustomerBackupDemo]
WHERE [age] >=27
);

UPDATE [dbo].[Day6CustomerUpdateDemo]
SET [salary] *=0.25
WHERE [age] IN (
SELECT [age] FROM [dbo].[Day6CustomerBackupDemo]
WHERE [age]>=30
);

SELECT * FROM [dbo].[Day6CustomerUpdateDemo] WHERE [age] 
IN (
SELECT [age] FROM [dbo].[Day6CustomerBackupDemo] 
WHERE [age]>=30
);

/* Using your two existing tables, write a query to delete Amit and Sara from
Day6CustomerUpdateDemo, using a subquery that selects customers 
whose age is at least 30 from Day6CustomerBackupDemo.*/

DELETE FROM [dbo].[Day6CustomerUpdateDemo]
WHERE [age] IN (
SELECT [age] FROM [dbo].[Day6CustomerBackupDemo] 
WHERE [age]>=30
);
