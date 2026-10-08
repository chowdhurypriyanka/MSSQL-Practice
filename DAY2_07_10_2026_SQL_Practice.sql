CREATE TABLE [EmployeeDepartment](
 [emp_id] INT,
 [dept_id] INT,
 [emp_name] VARCHAR(50),
 PRIMARY KEY ([emp_id],[dept_id])
);


INSERT INTO [EmployeeDepartment] ([emp_id],[dept_id],[emp_name]) VALUES (101,10,'Priyanka'),
(101,20,'Priyanka'),(102,10,'Rahul'),(103,10,'Amit');

-----------------

CREATE TABLE [StudentContact](
[student_id] INT,
[student_name] VARCHAR(50),
[phone] VARCHAR(20)
);

INSERT INTO [StudentContact] ([student_id],[student_name],[phone]) VALUES (1,'Priyanka', 9876543210),
(2,'Rahul',NULL),(3,'Amit',9123456780);

SELECT * FROM [StudentContact] WHERE [phone] is NULL;

UPDATE [StudentContact]
SET [phone] = '9999999999'
WHERE [phone] is NULL;

ALTER TABLE [StudentContact]
ALTER COLUMN [phone] VARCHAR(20) NOT NULL;

-------------------------------
1 | Priyanka | priya@gmail.com
2 | Rahul    | rahul@gmail.com

CREATE TABLE [UserAccount](
[user_id] INT PRIMARY KEY,
[username] VARCHAR(50),
[email] VARCHAR(100) UNIQUE
);
INSERT INTO [UserAccount] ([user_id],[username],[email]) VALUES (1,'Priyanka','priya@gmail.com'),
(2,'Rahul','rahul@gmail.com');

    SELECT * FROM [UserAccount];

 INSERT INTO [UserAccount] ([user_id],[username]) VALUES (3,'Amit');
------------------------------------------------------

CREATE TABLE [ProductCheck](
[product_id] INT PRIMARY KEY,
[product_name] VARCHAR(50),
[price] DECIMAL(10,2) CHECK ([price]>0)
);

INSERT INTO [ProductCheck] ([product_id],[product_name],[price]) VALUES (1,'Laptop',55000.00);
------------------------------------------------------------------
CREATE TABLE [EmployeeDefault](
[emp_id] INT,
[emp_name] VARCHAR(50),
[city] VARCHAR(50) DEFAULT 'Kolkata',
[salary] DECIMAL(10,2) DEFAULT 20000.00
);

INSERT INTO [EmployeeDefault] ([emp_id],[emp_name]) VALUES (1,'Priyanka');
SELECT * FROM [EmployeeDefault];
-- Explicit NULL → NULL
INSERT INTO EmployeeDefault (emp_id, emp_name, city)
VALUES (6, 'Sita', NULL);
-------------------------
CREATE TABLE [EmployeeRules](
[emp_id] INT PRIMARY KEY,
[emp_name] VARCHAR(50) NOT NULL,
[email] VARCHAR(100) UNIQUE,
[age] INT CHECK ([age]>=18),
[city] VARCHAR(50) DEFAULT 'Kolkata',
[salary] DECIMAL(10,2) DEFAULT 20000.00
);

INSERT INTO [EmployeeRules] ([emp_id],[emp_name],[email],[age],[city],[salary]) VALUES
(101,'Priyanka','priya@gmail.com',23,'Mumbai',45000);
INSERT INTO [EmployeeRules] ([emp_id],[emp_name],[email],[age]) VALUES
(102,'Rahul','rahul@gmail.com',25);

INSERT INTO [EmployeeRules] ([emp_id],[emp_name],[email],[age],[city],[salary]) VALUES
(106,'Riya','riya@gmail.com',NULL,'Kolkata',25000);

SELECT *
FROM [EmployeeRules]
WHERE [emp_id] = 106;

---Use your actual PaintDB.products table.
--Q1: Display product_name and category, sorted by product_name in ascending order.
--Q2: Display product_name and category, sorted by product_name in descending order.

SELECT [product_name],[category] FROM [AssignmentDB].[PaintDB].[products] ORDER BY [product_name] ASC;
SELECT [product_name],[category] FROM [AssignmentDB].[PaintDB].[products] ORDER BY [product_name] DESC;

SELECT [product_name],[category] FROM [AssignmentDB].[PaintDB].[products]
ORDER BY  [category] ASC, [product_name] ASC;

SELECT [product_name],[category] FROM [AssignmentDB].[PaintDB].[products]
ORDER BY  [category] DESC, [product_name] ASC;
----------------------------------------------
--Write a query to display each distinct category using GROUP BY.

SELECT DISTINCT [category] FROM [AssignmentDB].[PaintDB].[products] GROUP BY [category];

--Now write a query to show:
--category number_of_products where number_of_products is the number of products in each category.
--Use: COUNT(*) and give the count column an alias: number_of_products

SELECT [category], COUNT(*) AS number_of_products
FROM [AssignmentDB].[PaintDB].[products] GROUP BY [category];

SELECT * FROM [AssignmentDB].[PaintDB].[products];

SELECT [category], COUNT(*) AS number_of_products FROM [AssignmentDB].[PaintDB].[products]
GROUP BY [category] HAVING COUNT(*)>=5;

-- Q5: Find each category and the average voc_level_g_l for that category,
--but show only categories where the average is greater than 50.

SELECT [category], AVG(voc_level_g_l) AS average_voc FROM [AssignmentDB].[PaintDB].[products] 
GROUP BY [category] HAVING AVG(voc_level_g_l)>50;

--Q6: Display: category ,product_count for each category, but show only categories having at least 5 products, 
--and sort the result by product_count in descending order.

SELECT [category] , COUNT(*) AS product_count FROM [AssignmentDB].[PaintDB].[products]
GROUP BY [category] HAVING COUNT(*)>=1 ORDER BY [product_count] DESC;

---Q7:Using your actual products table, write a query to display: category average_voc for each category,
---but only where: AVG(voc_level_g_l) <= 50 and sort average_voc in ascending order.

SELECT [category], AVG(voc_level_g_l) AS [average_voc] FROM [AssignmentDB].[PaintDB].[products]
GROUP BY [category] HAVING AVG(voc_level_g_l)<=50 ORDER BY [average_voc] ASC;
--------------------------------------------

SELECT DISTINCT [category] FROM [AssignmentDB].[PaintDB].[products];

--Q2: Display all unique combinations of:category ,finish_type
SELECT DISTINCT [category],[finish_type] FROM [AssignmentDB].[PaintDB].[products];

SELECT *
FROM [AssignmentDB].[PaintDB].[products]
WHERE [category] IN ('Exterior', 'Interior');
---------------------------------------
SELECT [product_name],[category] FROM [AssignmentDB].[PaintDB].[products]
WHERE [category] IN ('Exterior','Interior');

SELECT * FROM [AssignmentDB].[PaintDB].[products] WHERE [finish_type] IN ('Matt','Gloss');

SELECT *
FROM [AssignmentDB].[PaintDB].[products]
WHERE [category] IN ('Exterior','Interior','Industrial');

--Q1 Using our Customers and Orders tables, write a query to display: customer_name for customers 
--who have at least one order. Use IN with a subquery.
SELECT [customer_name] FROM [Customers] WHERE [customer_id] IN
(
SELECT [customer_id] FROM [Orders]
);

SELECT [customer_name],[customer_id] FROM [Customers] WHERE [customer_id] IN
(
SELECT [customer_id] FROM [Orders]
);

SELECT [product_id], [product_name] FROM [AssignmentDB].[PaintDB].[products] 
WHERE [product_name] LIKE '%Paint%';

SELECT * FROM [AssignmentDB].[PaintDB].[products];

SELECT [product_name] FROM [AssignmentDB].[PaintDB].[products] 
WHERE [product_name] LIKE 'A%';

SELECT [product_name] FROM [AssignmentDB].[PaintDB].[products] 
WHERE [product_name] LIKE '%Guard';

SELECT [product_name],[category] FROM [AssignmentDB].[PaintDB].[products]
WHERE [category] = 'Exterior' AND [finish_type]='Matt';
SELECT * FROM  [AssignmentDB].[PaintDB].[products] WHERE  [category] = 'Interior'
AND [binder_type] = 'Acrylic';

SELECT * FROM  [AssignmentDB].[PaintDB].[products] WHERE  [category] = 'Exterior'
AND [product_name] LIKE '%Paint%';

--Q1 Find products where: category is Exterior OR Interior, and finish type is Matt.
SELECT * FROM  [AssignmentDB].[PaintDB].[products] WHERE  ([category] = 'Exterior' OR [category]='Interior')
AND [finish_type] = 'Matt';
--Q2 Find products where:category is Exterior, OR category is Interior AND binder type is Acrylic.
SELECT * FROM  [AssignmentDB].[PaintDB].[products] WHERE  ([category] = 'Exterior' OR [category]='Interior')
AND [binder_type] = 'Acrylic';

SELECT [product_name],[category] AS [product_category] FROM  [AssignmentDB].[PaintDB].[products];
SELECT [product_name],[category] FROM  [AssignmentDB].[PaintDB].[products] AS [p];
SELECT [product_name] AS [Product Name],[category] AS [Product Category] 
FROM  [AssignmentDB].[PaintDB].[products] AS [p];

SELECT 
  [product_name],[voc_level_g_l], 
CASE
   WHEN voc_level_g_l > 100 THEN 'High'
   ELSE 'Low'
  END AS VOC_Category
FROM [AssignmentDB].[PaintDB].[products];

SELECT * ,
CASE
 WHEN [voc_level_g_l] >100 THEN 'High'
 WHEN [voc_level_g_l] IN (50,100) THEN 'Medium'
 WHEN [voc_level_g_l]<50 THEN 'Low'
 END AS VOC_Category
 FROM [AssignmentDB].[PaintDB].[products];

--Q4 Write a query to show: category high_voc_count where high_voc_count is 
--the number of products in each category whose voc_level_g_l > 100.

SELECT [category],SUM(
CASE
WHEN [voc_level_g_l] >100 THEN 1
ELSE 0
END)  AS high_voc_count
FROM  [AssignmentDB].[PaintDB].[products]
GROUP BY [category];
-------------------------
SELECT [category],
SUM(
CASE WHEN [voc_level_g_l]<50 THEN 1
ELSE 0
END) AS low_voc_count
FROM [AssignmentDB].[PaintDB].[products]
GROUP BY [category];
-----------------------------

SELECT [product_name],[voc_level_g_l],
CASE
WHEN [voc_level_g_l] >100 THEN 'High'
WHEN [voc_level_g_l] >=50 AND [voc_level_g_l] <=100 THEN 'Medium'
WHEN [voc_level_g_l] <50 THEN 'Low'
END AS VOC_Category
FROM [AssignmentDB].[PaintDB].[products];

SELECT * FROM [Employee2];

UPDATE [Employee2]
SET [city] = 'PUNE'
WHERE [city] IS NULL;

ALTER TABLE [Employee2]
ALTER COLUMN [city] VARCHAR(20) NOT NULL;

UPDATE [Employee2]
SET [city] = 'Kolkata'
WHERE [emp_id] = 100;

UPDATE [Employee2]
SET [city] = 'Mumbai'
WHERE [emp_id] = 101;

UPDATE [Employee2]
SET [city] = 'Delhi' ,[salary] =55000.00
WHERE [emp_id] = 102;

UPDATE [Employee2]
SET [city] = 'Pune'
WHERE [emp_id] = 103;

UPDATE [Employee2]
SET [salary] =[salary]+5000
WHERE [department]='IT';
------------------------------
CREATE TABLE EmployeeTarget
(
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2)
);

INSERT INTO EmployeeTarget
(emp_id, emp_name, salary)
VALUES
(1, 'Priyanka', 45000),
(2, 'Rahul', 40000),
(4, 'Amit', 50000);

CREATE TABLE EmployeeSource
(
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2)
);

INSERT INTO EmployeeSource
(emp_id, emp_name, salary)
VALUES
(1, 'Priyanka', 48000),
(2, 'Rahul', 40000),
(3, 'Neha', 42000);

SELECT * FROM [EmployeeSource];

MERGE [EmployeeTarget] as t
USING [EmployeeSource] as s
ON [t].[emp_id] = [s].[emp_id]
WHEN MATCHED THEN
UPDATE 
SET [t].[emp_id] = [s].[emp_id],
[t].[emp_name] = [s].[emp_name],
[t].[salary]=[s].[salary]
WHEN NOT MATCHED THEN
INSERT ([emp_id],[emp_name],[salary]) VALUES ([s].[emp_id],[s].[emp_name],[s].[salary])
WHEN NOT MATCHED BY SOURCE THEN
DELETE;

SELECT * FROM [EmployeeTarget];