CREATE DATABASE SQLPracticeDB;
USE SQLPracticeDB;

-------------------
CREATE DATABASE MyFirstDB;
USE  MyFirstDB;

CREATE SCHEMA HR;

CREATE TABLE [HR].[jobs](
[job_id] INT PRIMARY KEY IDENTITY,
[customer_id] INT NOT NULL,
[description] VARCHAR(200),
[created_at] DATETIME2 NOT NULL
);

----------------

CREATE SCHEMA [Student];

CREATE TABLE [Student].[Students](
[student_id] INT PRIMARY KEY IDENTITY,
[student_name] VARCHAR(30),
[age] INT NOT NULL,
[city] VARCHAR(20)
);

DROP TABLE [Student].[Students];

CREATE TABLE [Customers](
customer_id INT,
customer_name VARCHAR(50)
);

CREATE TABLE [Orders](
order_id INT,
customer_id INT,
order_date DATE
);

INSERT INTO [Customers] ([customer_id],[customer_name]) VALUES (1,'Priya'),(2,'Rahul'),(3,'Amit');

INSERT INTO [Orders] ([order_id],[customer_id],[order_date]) VALUES (101,1,'2026-10-01'),(102,1,'2026-10-02'),(103,2,'2026-10-03'),
(104,3,'2026-10-04'),(105,1,'2026-10-05');

SELECT * FROM Customers;
SELECT * FROM Orders;

---Without using JOIN yet, write a query to show only the orders belonging to customer 1.---

SELECT * FROM [Orders] WHERE [customer_id]=1;


---q8 Write a query to show only the customer names from the Customers table.

SELECT [customer_name] FROM [Customers];

--q9 Write a query to show only order_id and order_date from the Orders table.

SELECT [order_id],[order_date] FROM [Orders];

--q10 Write a query to find all orders where customer_id = 2.

SELECT * FROM [Orders] WHERE [customer_id] = 2;

---- DECIMAL(P,S)

--P = total digits
--S = digits after decimal
--Precision
--Scale--

------------------
CREATE TABLE [Employee](
emp_id INT,
emp_name VARCHAR(50),
age INT ,
salary DECIMAL(10,2),
joining_date DATE
);

CREATE TABLE [Product](
product_id INT ,
product_name VARCHAR(100),
price DECIMAL(8,2),
is_available BIT
);



INSERT INTO [Product] ([product_id],[product_name],[price],[is_available]) VALUES (101,'Laptop',55000.50,1);
INSERT INTO [Product] ([product_id],[product_name],[price],[is_available]) VALUES (102, 'Mouse', 850.75,1);
INSERT INTO [Product] ([product_id] , [product_name], [price],[is_available]) VALUES (103,'Keyboard', 1250.00,0);

SELECT [product_name],[price] FROM [Product]; 
SELECT * FROM [Product] WHERE [is_available]=1;

CREATE TABLE [Person](
person_id INT,
name NVARCHAR(50)
);
--------

CREATE TABLE [UserDetails]
(
    user_id INT,
    user_name NVARCHAR(50),
    birth_date DATE,
    login_time TIME,
    created_at DATETIME,
    is_active BIT
);



INSERT INTO [UserDetails] ([user_id],[user_name],[birth_date],[login_time],[created_at],[is_active]) VALUES 
(1,'Priyanka','2003-05-15', '10:30:00','2026-10-06 10:30:00',1);

INSERT INTO [UserDetails] ([user_id],[user_name],[birth_date],[login_time],[created_at],[is_active]) VALUES
(2,'Rahul','2002-08-20','09:15:00','2026-10-06 09:15:00',0);

SELECT [user_name],[birth_date],[is_active] FROM [UserDetails];

-----------------------------------

CREATE TABLE [Employee2](
emp_id INT IDENTITY(100,1) PRIMARY KEY,
emp_name VARCHAR(50) NOT NULL,
department VARCHAR(50),
salary DECIMAL(10,2)
);

INSERT INTO [Employee2] ([emp_name],[department],[salary]) VALUES ('Priyanka','IT',45000.00),
('Rahul','HR', 40000.00),('Amit','Finance',50000.00);

SELECT * FROM [Employee2];


INSERT INTO [Employee2] ([emp_name],[department],[salary]) VALUES ('Neha','IT',42000.00);

ALTER TABLE [Customers]
ALTER COLUMN [customer_id] INT NOT NULL;

SELECT * FROM [Customers];

ALTER TABLE [Customers]
ADD CONSTRAINT PK_customers
PRIMARY KEY ([customer_id]);

ALTER TABLE [Orders]
ADD CONSTRAINT FK_Orders_Customers
FOREIGN KEY (customer_id)
REFERENCES [Customers]([customer_id]);

INSERT INTO [Orders]
([order_id], [customer_id], [order_date])
VALUES
(106, 2, '2026-10-06');

DELETE FROM [Customers]
WHERE customer_id =2;

SELECT * FROM [Orders] WHERE [customer_id] =2;

DELETE FROM [Orders] WHERE [order_id] =106;

CREATE TABLE [IdentityTest](
id INT IDENTITY(100,1),
name VARCHAR(50)
);

INSERT INTO [IdentityTest] ([name]) VALUES ('A'),('B');

SELECT * FROM [IdentityTest];

DELETE FROM [IdentityTest];

INSERT INTO [IdentityTest] ([name]) VALUES ('C');

TRUNCATE TABLE [IdentityTest];

INSERT INTO IdentityTest ([name])
VALUES ('D');



ALTER TABLE [Employee2]
ADD email VARCHAR(100);

ALTER TABLE [Employee2]
ADD phone VARCHAR(20);

SELECT * FROM [Employee2];

ALTER TABLE [Employee2]
ALTER COLUMN email VARCHAR(200);

ALTER TABLE [Employee2]
ALTER COLUMN email VARCHAR(150);

ALTER TABLE [Employee2]
ALTER COLUMN phone VARCHAR(30);

ALTER TABLE [Employee2]
ALTER COLUMN salary decimal(10,2);

ALTER TABLE [Employee2]
DROP COLUMN phone;

ALTER TABLE [Employee2]
DROP COLUMN email;

SELECT product_name,price
INTO #AvailableProducts
FROM [Product]
WHERE is_available =1;

SELECT * FROM #AvailableProducts;

SELECT [product_name],[price]
INTO #ExpensiveProducts
FROM [Product]
WHERE [price] >1000;

SELECT * FROM #ExpensiveProducts;

CREATE TABLE #Costly_product(
[product_name] VARCHAR(MAX),
[price] DECIMAL(10,2)
);

INSERT INTO #Costly_product
SELECT [product_name],[price]
FROM Product
WHERE [price] >1000;

SELECT * FROM #Costly_product;



CREATE TABLE #AvailableProduct (
[product_name] VARCHAR(100),
[price] DECIMAL(10,2)
);

INSERT INTO #AvailableProduct 
SELECT [product_name],[price] FROM [Product] 
WHERE [is_available] = 1 ;

SELECT * FROM #AvailableProduct;

CREATE TABLE ##berger_products
(
    product_name VARCHAR(MAX),
    list_price DEC(10,2)
);

CREATE TABLE ##berger_Productss(
[product_name] VARCHAR(MAX),
[binder_type] VARCHAR(MAX)
);

INSERT INTO ##berger_productss
SELECT [product_name],[binder_type]
FROM [AssignmentDB].[PaintDB].[products]
WHERE [category] = 'Exterior';

SELECT * FROM ##berger_Productss;

CREATE TABLE ##ExteriorProducts
(
    product_name VARCHAR(100),
    category VARCHAR(50)
);

INSERT INTO ##ExteriorProducts
SELECT [product_name],[category]
FROM [AssignmentDB].[PaintDB].[products]
WHERE [category] = 'Exterior';

SELECT * FROM ##ExteriorProducts;


-------------Final quizz-----

--q1
SELECT [product_id],[product_name],[category] FROM [AssignmentDB].[PaintDB].[products];

--q2
SELECT * FROM [AssignmentDB].[PaintDB].[products]
WHERE [category] = 'Exterior';
--q3
CREATE TABLE #MattProducts(
  [product_name] VARCHAR(100),
  [finish_type] VARCHAR(50)
);

INSERT INTO #MattProducts
SELECT [product_name],[finish_type]
FROM [AssignmentDB].[PaintDB].[products]
WHERE [finish_type]='Matt';

SELECT * FROM #MattProducts;
--q4
CREATE TABLE [EmployeePractice](
emp_id INT,
emp_name VARCHAR(20),
salary DECIMAL(8,2)
);
ALTER TABLE [EmployeePractice]
ADD  [email] VARCHAR(100);