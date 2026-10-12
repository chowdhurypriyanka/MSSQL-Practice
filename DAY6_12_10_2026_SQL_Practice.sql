USE MyFirstDB;
GO

CREATE TABLE [dbo].[Day7Practice]
(
    [person_id] INT PRIMARY KEY,
    [person_name] VARCHAR(50),
    [phone] VARCHAR(20) NULL,
    [min_age] INT NULL,
    [max_age] INT NULL,
    [city] VARCHAR(30),
    [salary] DECIMAL(10,2),
    [join_date] DATE,
    [amount_text] VARCHAR(20)
);
GO

INSERT INTO [dbo].[Day7Practice]
    ([person_id], [person_name], [phone], [min_age], [max_age],
     [city], [salary], join_date, [amount_text])
VALUES
    (1, 'Priya', '9876543210', NULL, 60,
     'Kolkata', 45000, '2022-06-15', '125.50'),

    (2, 'Rahul', NULL, 25, NULL,
     'Delhi', 52000, '2021-11-03', 'abc'),

    (3, 'Amit', '', 30, 65,
     'Kolkata', 52000, '2023-01-20', '300'),

    (4, 'Neha', NULL, NULL, 55,
     'Mumbai', 38000, '2024-04-12', ''),

    (5, 'Sara', '9123456780', 28, 58,
     'Delhi', 60000, '2020-12-01', '450.75');

     SELECT *
FROM dbo.Day7Practice;

SELECT [person_name] , ISNULL([min_age],0) 
AS [min_age] FROM [Day7Practice];

SELECT [person_name], ISNULL([phone],'Not Available') AS [phone] FROM [Day7Practice];

/* Q1. Display person_name and max_age. If max_age is NULL, display 99 instead. 
Name the result column max_age.
Q2. Display person_name and phone. If phone is NULL, display 'No Phone' instead.*/

SELECT [person_name],[max_age] , ISNULL([max_age],99) AS [max_age] FROM [Day7Practice];

SELECT [person_name], [phone], ISNULL([phone],'No Phone') AS [phone] FROM [Day7Practice];

SELECT [person_name] , ISNULL([phone],'') AS [phone] FROM [Day7Practice];

/* Q5. Write a query to display person_name and phone, converting empty phone strings into NULL with NULLIF().*/

SELECT [person_name],[phone], NULLIF([phone],'') AS [phone] FROM [Day7Practice];

/* Q6. Write a query to display person_name and phone, converting empty
phone strings into NULL and then replacing any 
resulting NULL with 'No Phone' using ISNULL().*/

SELECT [person_name],[phone], ISNULL(NULLIF([phone],''),'No Phone') AS [phno] FROM [Day7Practice];
--------------------------

SELECT COALESCE(NULL, NULL, 'Hi') AS result;

SELECT [person_name] , COALESCE([phone],[city],'Not Available') AS [contact_info] FROM [Day7Practice];

----- SCOPE IDENTITY----

USE MyFirstDB;
GO

DROP TABLE IF EXISTS dbo.Day7IdentityDemo;
CREATE TABLE dbo.Day7IdentityDemo
(
    id INT IDENTITY(1,1) PRIMARY KEY,
    person_name VARCHAR(50)
);
GO
INSERT INTO dbo.Day7IdentityDemo (person_name)
VALUES ('Priya');

SELECT SCOPE_IDENTITY() AS last_generated_id;

SELECT *
FROM dbo.Day7IdentityDemo;

INSERT INTO [dbo].[Day7IdentityDemo] ([person_name]) VALUES ('Rahul');

SELECT SCOPE_IDENTITY() AS last_generated_id;

SELECT IIF(10<20,'True','False') AS result;

SELECT [person_name],[salary] , IIF([salary]>=50000,'High','Standered') AS [salary2] FROM [Day7Practice];

/* Q10. Using Day7Practice, write a query displaying person_name and
a column named age_status. Return 'Adult' 
when min_age is at least 18, and 'Below Adult' otherwise.*/

SELECT [person_name] , IIF([min_age]>=18,'Adult','Below Adult') AS [age_status] FROM [Day7Practice];

--SUBSTRING---

SELECT SUBSTRING('Priyanka',1,4) AS reult;

/* Q11. Display person_name and the first 3 characters of each name in a column called short_name.
Q12. Display person_name and extract 3 characters starting from position 
2 in each name. Name the result column middle_part.*/

SELECT [person_name] , SUBSTRING([person_name],1,3) AS short_name FROM [Day7Practice];

SELECT [person_name], SUBSTRING([person_name],2,3) AS [middle_part] FROM [Day7Practice];

/* Q13. Display person_name and the first 4 characters of each name. Name the result column first_four.
Q14. Display person_name and the first 2 characters of each name. Name the result column initial_part.*/

SELECT [person_name] , LEFT([person_name],4) AS [first_four] FROM [Day7Practice];
SELECT [person_name], LEFT([person_name],2) FROM [Day7Practice];

/* Q15. Display person_name and the last 3 characters of each name. Name the result column last_three.
Q16. Display person_name and the last 2 characters of each name. Name the result column last_two.*/

SELECT [person_name], RIGHT([person_name],3) AS [last_three] FROM [Day7Practice];

SELECT [person_name], RIGHT ([person_name],2) AS [last_two] FROM [Day7Practice];

/* Q17. Write a query that displays person_name with leading spaces removed. Name the result column clean_name.
Q18. Write a query that displays person_name with trailing spaces removed. Name the result column clean_name.*/

SELECT [person_name] , LTRIM ([person_name]) AS [clean_name] FROM [Day7Practice];
SELECT [person_name], RTRIM ([person_name]) AS [clean_name] FROM [Day7Practice];

------------

SELECT REPLACE('Delhi is nice place.I love Delhi','Delhi','Kolkata') As[result];


/* Q19. Display person_name and city, replacing 'Kolkata' with 'Calcutta' in the displayed city value.
Name the result column updated_city.
Q20. Display person_name and city, replacing 'Delhi' with 'New Delhi' in the displayed city value.
Name the result column updated_city. */

SELECT [person_name],[city], REPLACE([city],'Kolkata','Calcutta') as [updated_city] FROM [Day7Practice];

SELECT [person_name],[city], REPLACE([city],'Delhi','New Delhi') AS [updated_city] FROM [Day7Practice];

SELECT STUFF('SQL Tutorial',1, 3, 'SQL Server') AS [result];

/*Q22. Using your Day7Practice table, write a query to display person_name and a 
modified name that replaces the first 2 characters of
each name with 'XX'. Name the result column modified_name.*/

SELECT [person_name] , STUFF([person_name],1,2,'XX') AS [modified_name] FROM [Day7Practice];

SELECT [person_name],[join_date], FORMAT([join_date],'dd/mm/yyyy') AS [fomated_date] FROM [Day7Practice];

SELECT [person_name], FORMAT([salary],'N2') AS [fomated_salary] FROM [Day7Practice];

SELECT DATEDIFF(Day, '2022-06-15',
    '2022-06-20') AS [Date_difference];

    /* Q25. Display person_name, join_date, and the number of days between join_date and '2025-01-01'. 
    Name the calculated column days_difference.
Q26. Display person_name and the difference in years between join_date and '2025-01-01'. 
Name the calculated column years_difference.*/

SELECT [person_name],[join_date], DATEDIFF(Day,[join_date],'2025-01-01') AS [days_difference] 
FROM [Day7Practice];

SELECT [person_name], DATEDIFF(YEAR,[join_date],'2025-01-01') AS [years_difference] 
FROM [Day7Practice];

/* Q27. Display person_name and the year extracted from join_date, naming the result column joining_year.
Q28. Display person_name and the month extracted from join_date, naming the result column joining_month.*/

SELECT [person_name] , DATEPART(YEAR,[join_date]) AS [joining_year] FROM [Day7Practice];
SELECT [person_name] , DATEPART(MONTH,[join_date]) AS [joining_month] FROM [Day7Practice];

/*Q29. Display person_name and the year from join_date using YEAR(). Name the result joining_year.
Q30. Display person_name and the month from join_date using MONTH(). Name the result joining_month.*/

SELECT [person_name], YEAR([join_date]) AS [joining_year] FROM [Day7Practice];
SELECT [person_name], MONTH([join_date]) AS [joining_month] FROM [Day7Practice];

SELECT CONVERT(DATE,'2026-10-12 14:35:20') AS [current_date];

SELECT CAST('2026-10-12 14:35:20' AS DATE) AS [curr_date];

/* Q33. Display person_name and convert amount_text to DECIMAL(10,2) using TRY_CAST(). 
Name the result column converted_amount.*/

SELECT [person_name], TRY_CAST([amount_text] AS DECIMAL(10,2)) AS [converted_name] FROM [Day7Practice];

SELECT ROUND(345.677,2) AS [round_value];
SELECT ROUND(123.456, 2) AS [result];

SELECT ROUND(987.654, 1) AS [result];

SELECT ISNUMERIC('123') AS [result];

SELECT ISNUMERIC('Hello') AS [result];

SELECT [value] FROM STRING_SPLIT('red,green,blue',',') ;

SELECT [value] FROM STRING_SPLIT('apple,banana,mango',',');

/* Q44. Write a query that generates a GUID and names the output column my_guid.*/

SELECT NEWID() AS [my_guid];

-----------RANK()------------------

SELECT [person_name],[salary], RANK() OVER (ORDER BY [salary] DESC) AS [salary_rank] FROM [Day7Practice];

/* Q46. Write a query using RANK() to rank people by salary from lowest to highest. 
Display person_name, salary, and salary_rank.*/

SELECT [person_name],[salary], RANK() OVER (ORDER BY [salary] ASC) AS [salary_rank] FROM [Day7Practice];

/* Q47. Write a query using DENSE_RANK() to rank people by salary from highest to lowest. 
Display person_name, salary, and salary_rank. */

SELECT [person_name],[salary], DENSE_RANK() OVER (ORDER BY [salary] DESC) AS [salary_rank] 
FROM [Day7Practice];

/* Q48. Write a query using ROW_NUMBER() to number people from the lowest salary to the highest salary.
Display person_name, salary, and row_num. Use ORDER BY [salary] ASC inside OVER().*/


SELECT [person_name],[salary] , ROW_NUMBER() OVER (ORDER BY [salary] ASC) AS [row_num] 
FROM [Day7Practice];

SELECT [person_name],[city],[salary], ROW_NUMBER() OVER (PARTITION BY [city] ORDER BY [salary] DESC)
AS [row_num] FROM [Day7Practice] ORDER BY [city],[row_num];

/* Display person_name, city, salary, and row_num.
Use ROW_NUMBER(), PARTITION BY, and ORDER BY salary ASC.*/

SELECT [person_name],[city],[salary], ROW_NUMBER() OVER(PARTITION BY [city] ORDER BY [salary] ASC)
AS [row_num] FROM [Day7Practice] ORDER BY [city],[row_num];

--- Pagination-----------

WITH NumberedPeople AS(
SELECT [person_name],
[city],
[salary],
ROW_NUMBER() OVER(ORDER BY [person_name] ASC) AS [row_num]
FROM [Day7Practice]
)SELECT 
[person_name],[city],[salary],[row_num] FROM NumberedPeople
WHERE [row_num] BETWEEN 2 AND 4
ORDER BY [row_num];

/* Assign row numbers to people by person_name in ascending order, then display only rows 2 through 4.
Use a CTE or subquery, and name the CTE NumberedPeople.*/

