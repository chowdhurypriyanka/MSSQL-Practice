SELECT * FROM [dbo].[Customers];

SELECT * FROM [dbo].[Orders];

SELECT 
[c].[customer_name],
[o].[order_id],
[o].[order_date]

FROM [dbo].[Customers] AS [c]
INNER JOIN [dbo].[Orders] AS [o]
ON [c].[customer_id]=[o].[customer_id];

INSERT INTO [dbo].[Customers]
    ([customer_id], [customer_name])
VALUES
    (4, 'Neha');

SELECT 
[c].[customer_name],
[o].[order_id]
FROM [dbo].[Customers] AS c
LEFT JOIN [dbo].[Orders] AS o
ON [c].[customer_id] = [o].[customer_id];

SELECT 
[c].[customer_id],
[c].[customer_name]
FROM [dbo].[Customers] AS [c]
LEFT JOIN [dbo].[Orders] AS [o]
ON [c].[customer_id] = [o].[customer_id]
WHERE [o].[order_id] IS NULL;

SELECT 
[c].[customer_name],
[o].[order_id],
[o].[order_date]
FROM [dbo].[Customers] AS [c]
RIGHT JOIN [dbo].[Orders] As [o]
ON [c].[customer_id] = [o].[customer_id]


SELECT 
[c].[customer_name],
[o].[order_id],
[o].[order_date]
FROM [dbo].[Customers] AS [c]
RIGHT JOIN [dbo].[Orders] As [o]
ON [c].[customer_id] = [o].[customer_id]
WHERE [c].[customer_id] is NULL;

INSERT INTO [dbo].[Orders] ([order_id],[order_date]) VALUES (106,'2026-10-08');
DELETE FROM [dbo].[Orders]
WHERE [order_id] = 106;

SELECT 
[c].[customer_name],
[o].[order_id],
[o].[order_date]
FROM [dbo].[Customers] AS [c]
FULL OUTER JOIN [dbo].[Orders] AS [o]
ON [c].[customer_id] = [o].[customer_id];

SELECT 
[c].[customer_name],
[o].[order_id],
[o].[order_date]
FROM [dbo].[Customers] AS [c]
FULL OUTER JOIN [dbo].[Orders] AS [o]
ON [c].[customer_id] = [o].[customer_id]
WHERE [c].[customer_id] IS NULL OR [o].[customer_id] IS NULL;

SELECT 
[c].[customer_name],
[o].[order_id]
FROM [Customers] AS [c]
CROSS JOIN [Orders] AS [o]

CREATE TABLE Employee3
(
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    manager_id INT NULL
);
DROP TABLE [Employee3];
CREATE TABLE Employee3
(
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50)
);
INSERT INTO Employee3 (emp_id, emp_name, department)
VALUES
(1, 'Priya', NULL),
(2, 'Rahul', NULL),
(3, 'Amit', NULL);
INSERT INTO Employee3 (emp_id, emp_name, manager_id)
VALUES
(1, 'Priya', NULL),
(2, 'Rahul', 1),
(3, 'Amit', 1),
(4, 'Neha', 2);

SELECT *
FROM [Employee3];

SELECT [e].[emp_name] AS employee,
[m].[emp_name] as manager
FROM [Employee3] as [e]
LEFT JOIN [Employee3] as[m]
ON [e].[manager_id] = [m].[emp_id];
------------------------------------
CREATE TABLE [EmployeeDepartment3]
(
    [emp_id] INT,
    [department] VARCHAR(50)
);

INSERT INTO [EmployeeDepartment3] ([emp_id], [department])
VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance');

SELECT *
FROM [EmployeeDepartment3];

UPDATE [e]
SET [e].[department] =[d].[department]
FROM [Employee3] AS [e]
INNER JOIN [EmployeeDepartment3] AS [d]
ON [e].[emp_id] = [d].[emp_id];

CREATE TABLE EmployeeDelete3
(
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50)
);

INSERT INTO EmployeeDelete3 (emp_id, emp_name, department)
VALUES
(1, 'Priya', 'IT'),
(2, 'Rahul', 'HR'),
(3, 'Amit', 'Finance');

CREATE TABLE EmployeeDepartmentDelete3
(
    emp_id INT,
    department VARCHAR(50)
);

INSERT INTO EmployeeDepartmentDelete3 (emp_id, department)
VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance');

SELECT * FROM EmployeeDelete3;
SELECT * FROM EmployeeDepartmentDelete3;

DELETE [e]
FROM [EmployeeDelete3] AS [e]
INNER JOIN [EmployeeDepartmentDelete3] AS [d]
ON [e].[emp_id]=[d].[emp_id]
WHERE [d].[department]  = 'Finance';