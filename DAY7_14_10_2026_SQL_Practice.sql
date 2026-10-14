USE MyFirstDB;
GO

CREATE TABLE dbo.Day8Orders
(
    order_id INT PRIMARY KEY,
    order_status INT,
    order_value DECIMAL(10,2)
);
GO
INSERT INTO dbo.Day8Orders
    (order_id, order_status, order_value)
VALUES
    (101, 1, 300.00),
    (102, 2, 750.00),
    (103, 4, 1200.00),
    (104, 3, 450.00),
    (105, 2, 900.00),
    (106, 4, 1500.00),
    (107, 1, 250.00),
    (108, 3, 600.00);

    SELECT *
FROM dbo.Day8Orders;

---------------------------

SELECT [order_id],[order_status], CASE [order_status]
WHEN 1 THEN 'Pending'
WHEN 2 THEN 'Processing'
WHEN 3 THEN 'Completed'
WHEN 4 THEN 'Rejected'
ELSE 'Unkown'
END AS [status_name]
FROM [Day8Orders];

/* Q1. Write a query to display order_id and a column named status_name, 
onverting the numeric status into its corresponding label using CASE.
Use the same mappings:
- 1 → Pending
- 2 → Processing
- 3 → Rejected
- 4 → Completed  */

SELECT [order_id] , CASE [order_status] 
WHEN 1 THEN 'Pending'
WHEN 2 THEN 'Processing'
WHEN 3 THEN 'Rejected'
WHEN 4 THEN 'Completed'
ELSE 'Unkown'
END AS [status_name]
FROM [Day8Orders];

-------------Searched Case---------------

SELECT [order_id],[order_value], CASE WHEN [order_value] <=500 THEN 'Low'
WHEN [order_value]  <=1000 THEN 'Medium'
ELSE 'High'
END AS [order_category] FROM [Day8Orders];

/* Q3. Using Day8Orders, write a searched CASE query to classify orders as follows:
- order_value below 400 → 'Small'
- order_value from 400 through 1000 → 'Medium'
- order_value above 1000 → 'Large'
Display order_id, order_value, and order_category. */

SELECT [order_id],[order_value],CASE 
WHEN [order_value] < 400 THEN 'Small'
WHEN [order_value] <= 1000 THEN 'Medium'
ELSE 'Large'
END AS [order_category] FROM [Day8Orders];
--------------------------------

SELECT 
SUM(
  CASE WHEN [order_status] =1 THEN 1 ELSE 0
  END 
) AS [Pending],
SUM (
CASE WHEN [order_status] = 4 THEN 1 ELSE 0 END
) AS [Completed],
COUNT (*) AS [total] FROM [Day8Orders];

/* Q4. Using Day8Orders, write a query that displays the count of:
- Pending orders as Pending_Count
- Processing orders as Processing_Count
- Rejected orders as Rejected_Count
- Completed orders as Completed_Count
- All orders as Total_Orders */

SELECT 
SUM (CASE WHEN [order_status] = 1 THEN 1 ELSE 0 END  ) AS [Pending_Count],
SUM (CASE WHEN [order_status] = 2 THEN 1 ELSE 0 END ) AS [Processing_Count],
SUM (CASE WHEN [order_status] = 3 THEN 1 ELSE 0 END ) AS [Rejected_Count],
SUM (CASE WHEN [order_status] = 4 THEN 1 ELSE 0 END ) AS [Completed_Count],
COUNT (*) AS[Total_Orders] FROM [Day8Orders];

-----------------WHILE LOOP---------------------

DECLARE @counter INT =1;
WHILE @counter <=5
BEGIN 
PRINT @counter;
SET @counter =@counter+1;
END;

DECLARE @cnt INT =2;
WHILE @cnt<10
BEGIN 
PRINT @cnt;
SET @cnt =@cnt+1;
END;

--------------CONTINUE------------

DECLARE @count INT =0;
WHILE @count <5
BEGIN 
SET @count=@count+1;
IF @count=3
 CONTINUE;
PRINT @count;
END;

--- Write a WHILE loop that prints numbers from 1 to 10 but skips 5 using CONTINUE.--

DECLARE @counts INT = 0;
WHILE @counts <=10
BEGIN
SET @counts = @counts+1;
IF @counts=5
  CONTINUE;
PRINT @counts;
END;

/* Write a WHILE loop that prints numbers from 1 to 10 but stops when the counter reaches 6.
Use BREAK to exit the loop immediately. */

DECLARE @num INT = 0;
WHILE @num <10
BEGIN
SET @num =@num +1;
IF @num = 6
 BREAK;
PRINT @num;
END;
------ Reading Table Data With While Loop------

DECLARE @number INT =101;
DECLARE @MaxId INT =108;
DECLARE @OrderStatus INT ;
WHILE @number <=@MaxId
BEGIN
SELECT @OrderStatus =[order_status] FROM [Day8Orders] WHERE [order_id] = @number ;
PRINT 'Order ID: '
        + CAST(@number AS VARCHAR(10))
        + ', Status: '
        + CAST(@OrderStatus AS VARCHAR(10));
SET @number = @number+1;
END;

----------------------

USE MyFirstDB;
GO

CREATE TABLE dbo.Day8BikeShop
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    bike_name VARCHAR(50) NOT NULL,
    price INT
);
GO

SELECT *
FROM dbo.Day8BikeShop
ORDER BY ID;

DECLARE @bike INT =1;
WHILE @bike<=10
BEGIN 
INSERT INTO [Day8BikeShop] ([bike_name],[price]) VALUES (
  'Bike - ' + CAST (@bike AS VARCHAR(10)),
  @bike * 5000
);
SET @bike = @bike+1;
END;

---------------WHILE LOOP WITH DATE-----------

DECLARE @date_start DATE = '2025-01-01';
DECLARE @date_end DATE ='2025-01-05';
DECLARE @loop_date DATE =@date_start;
WHILE @loop_date<=@date_end
BEGIN
PRINT CONVERT(VARCHAR(10), @loop_date, 120);
SET @loop_date = DATEADD(DAY, 1,@loop_date);
END;

CREATE TABLE #dates(
report_date DATE
);
DROP TABLE IF EXISTS #dates;
DECLARE @dt_start DATE = '2025-01-01';
DECLARE @dt_end DATE ='2025-01-05';
DECLARE @loop_dt DATE = @dt_start;
WHILE @loop_dt<=@dt_end
BEGIN
INSERT INTO #dates ([report_date]) VALUES (
@loop_dt);
SET @loop_dt = DATEADD(DAY,1,@loop_dt);
END;

SELECT *
FROM #dates
ORDER BY report_date;

/** Write a WHILE loop that:
1. Starts the counter at 0.
2. Prints numbers from 1 to 10.
3. Skips printing 5 using CONTINUE.
4. Stops the loop when the counter reaches 8, using BREAK. */

DECLARE @ct INT = 0;
WHILE @ct<10 
BEGIN
SET @ct =@ct +1;
IF @ct =5 
CONTINUE;
IF @ct = 8
BREAK;
PRINT @ct;
END;