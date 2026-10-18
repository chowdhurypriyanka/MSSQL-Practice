CREATE DATABASE SQLTrainingDB;
GO

USE SQLTrainingDB;
GO

SELECT DB_NAME() AS CurrentDatabase;

USE SQLTrainingDB;
GO

CREATE TABLE Customers
(
    CustomerName VARCHAR(50),
    ProductName VARCHAR(50),
    Amount INT
);

INSERT INTO Customers VALUES ('James', 'Laptop', 30000);
INSERT INTO Customers VALUES ('James', 'Desktop', 25000);
INSERT INTO Customers VALUES ('David', 'Laptop', 25000);
INSERT INTO Customers VALUES ('Smith', 'Desktop', 30000);
INSERT INTO Customers VALUES ('Pam', 'Laptop', 45000);
INSERT INTO Customers VALUES ('Pam', 'Laptop', 30000);
INSERT INTO Customers VALUES ('John', 'Desktop', 30000);
INSERT INTO Customers VALUES ('John', 'Desktop', 30000);
INSERT INTO Customers VALUES ('John', 'Laptop', 30000);

SELECT *
FROM Customers;

--------PIVOT-----------

SELECT [CustomerName],[Laptop],[Desktop]
FROM (
SELECT * FROM [Customers]
) AS PivotData
PIVOT(
SUM([Amount])
FOR [ProductName] IN ([Laptop],[DeskTop])
) AS PivotTable;


SELECT [CustomerName] ,[Laptop],[Desktop] FROM (
SELECT * FROM [Customers]
)AS PivotData
PIVOT
(COUNT(Amount)
FOR [ProductName] IN ([Laptop],[Desktop])
) AS PivotTable;

SELECT * FROM [Customers];

----ADDING ANOTHER GROUPING COLUMN IN PIVOT------

SELECT [CustomerName],[PurchaseYear], [Laptop],[Desktop]
FROM (
SELECT [CustomerName],
CASE
WHEN [ProductName]='Laptop' THEN 2024
ELSE 2025
END AS [PurchaseYear],
[ProductName],
[Amount]
FROM [Customers]
) AS PivotData
PIVOT (
SUM(Amount)
FOR [ProductName] IN ([Laptop],[Desktop])
) AS PivotTable
ORDER BY [CustomerName],[PurchaseYear];
------------------------------------------

DECLARE @colums NVARCHAR(MAX)='';
SELECT @colums+= QUOTENAME([ProductName])+',' FROM
(
SELECT DISTINCT [ProductName] FROM [Customers]
) AS ProductList
ORDER BY [ProductName];
SET @colums= LEFT(@colums,LEN(@colums)-1);
PRINT @colums;

-------------UNPIVOT----------------

USE SQLTrainingDB;
GO

CREATE TABLE ProductSales
(
    AgentName VARCHAR(50),
    India INT,
    US INT,
    UK INT
);

INSERT INTO ProductSales
VALUES ('Smith', 9160, 5220, 3360);

INSERT INTO ProductSales
VALUES ('David', 9770, 5440, 8800);

INSERT INTO ProductSales
VALUES ('James', 9870, 5480, 8900);

SELECT *
FROM ProductSales;

SELECT [AgentName],[Country],[SalesAmount]
FROM (
SELECT * FROM [ProductSales]
) AS ActualData
UNPIVOT(
SalesAmount
FOR [Country] IN (India,UK,US)
) AS PivotData;

