USE MyFirstDB;
GO

CREATE TABLE Day9Employee
(
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100),
    EmailID VARCHAR(100),
    Gender VARCHAR(20),
    Department VARCHAR(50),
    Salary INT,
    Age INT,
    City VARCHAR(100)
);
GO
INSERT INTO Day9Employee
    (Name, EmailID, Gender, Department, Salary, Age, City)
VALUES
    ('Pranaya',  'Pranaya@g.com',  'Male',   'IT',      25000, 30, 'Mumbai'),
    ('Tarun',    'Tarun@g.com',    'Male',   'Payroll', 30000, 27, 'Odisha'),
    ('Priyanka', 'Priyanka@g.com', 'Female', 'IT',      27000, 25, 'Bangalore'),
    ('Preety',   'Preety@g.com',   'Female', 'HR',      35000, 26, 'Bangalore'),
    ('Ramesh',   'Ramesh@g.com',   'Male',   'IT',      26000, 27, 'Mumbai'),
    ('Pramod',   'Pramod@g.com',   'Male',   'HR',      29000, 28, 'Odisha'),
    ('Anurag',   'Anurag@g.com',   'Male',   'Payroll', 27000, 26, 'Odisha'),
    ('Hina',     'Hina@g.com',     'Female', 'HR',      26000, 30, 'Mumbai'),
    ('Sambit',   'Sambit@g.com',   'Male',   'Payroll', 30000, 25, 'Odisha'),
    ('Manoj',    'Manoj@g.com',    'Male',   'HR',      30000, 28, 'Odisha'),
    ('Sara',     'Sara@g.com',     'Female', 'Payroll', 28000, 27, 'Mumbai'),
    ('Lima',     'Lima@g.com',     'Female', 'HR',      30000, 30, 'Bangalore'),
    ('Dipak',    'Dipak@g.com',    'Male',   'Payroll', 32000, 25, 'Bangalore');

    SELECT *
FROM Day9Employee;

SELECT * FROM [Day9Employee] WHERE [Salary] >=27000 AND [Salary]<=30000;
------------AND OPERATOR-------------------

/* Q1. Display employees who belong to the IT department and have a salary greater than ₹25,000. Show Name, Department, and Salary.
Q2. Display employees whose City is Mumbai and whose Age is greater than or equal to 28. Show Name, City, and Age.*/

SELECT [Name],[Department],[Salary] FROM [Day9Employee] WHERE [Department] = 'IT' AND [Salary] >25000;

SELECT [City],[Age] FROM [Day9Employee] WHERE [City]='Mumbai' AND [Age]>28 OR [Age]=28;

/* Q3. Display employees who work in the IT department or have a salary greater than 30,000. Show Name, Department, and Salary.
Q4. Display employees who live in Mumbai or Bangalore. Show Name and City.*/

SELECT [Name],[Department],[Salary] FROM [Day9Employee] WHERE [Department]='IT' OR [Salary] >30000;

SELECT [Name],[City] FROM [Day9Employee] WHERE [City]='Mumbai' OR  [City] = 'Bangalore';

/*Q5. Display employees who do not belong to the HR department. Show Name and Department.
Q6. Display employees who do not live in Odisha. Show Name and City.*/

SELECT [Name],[Department] FROM [Day9Employee] WHERE [Department] <> 'HR';
SELECT [Name],[City] FROM [Day9Employee] WHERE NOT [City] = 'Odisha';

/*Q7. Display Name, Salary, and Age for employees whose salary is between ₹26,000 and ₹30,000, inclusive.
Q8. Display Name, Age, and City for employees whose age is between 25 and 28, inclusive.*/

SELECT [Name],[Salary],[Age] FROM [Day9Employee] WHERE [Salary]  BETWEEN 26000 AND 30000 ;

SELECT [Name],[Age],[City] FROM [Day9Employee] WHERE [Age] BETWEEN 25 AND 28;

/*Q9. Display Name and Salary for employees whose salary is not between ₹26,000 and ₹30,000.
Q10. Display Name and Age for employees whose age is not between 25 and 28.*/

SELECT [Name],[Salary] FROM [Day9Employee] WHERE [Salary] NOT BETWEEN 26000 AND 30000;

SELECT [Name],[Age] FROM [Day9Employee] WHERE [Age] NOT BETWEEN 25 AND 28;

/*Q11. Display Name, Department, and Salary for employees whose department is either Payroll or HR. Use IN.
Q12. Display Name and City for employees who live in Mumbai, Odisha, or Bangalore. Use IN.*/

SELECT [Name],[Department], [Salary] FROM [Day9Employee] WHERE [Department] IN ('HR','Payroll');
SELECT [Name],[City] FROM [Day9Employee] WHERE [City] IN ('Mumbai','Odisha','Bangalore');

/*Q13. Display Name, Department, and Salary for employees who are not in the Payroll department.
Q14. Display Name and City for employees who live neither in Mumbai nor in Odisha.*/

SELECT [Name],[Department], [Salary] FROM [Day9Employee] WHERE [Department] NOT IN ('Payroll');
SELECT [Name],[City] FROM [Day9Employee] WHERE [City] NOT IN ('Mumbai','Odisha');
/*Q15. Display Name and Department for employees whose names start with S.
Q16. Display Name and Salary for employees whose names end with a.*/

SELECT [Name],[Department] FROM [Day9Employee] WHERE [Name] LIKE 's%';
SELECT [Name],[Salary] FROM [Day9Employee] WHERE [Name] LIKE '%a';

/*Q17. Display Name and Department for employees whose names contain exactly four characters, using _.
Q18. Display Name for employees whose names start with either P or S, using [].*/

----------------WILDCARD---------------

SELECT [Name],[Department] FROM [Day9Employee] WHERE [Name] LIKE '____';
SELECT [Name] FROM [Day9Employee] WHERE [Name] LIKE '[PS]%';

/*Q19. Display Name and Department for employees whose names do not start with either P or S. Use the [^] wildcard.*/

SELECT [Name],[Department] FROM [Day9Employee] WHERE [Name] LIKE '[^PS]%'

/*Q20. Display Name and Department for employees whose department has at least one employee earning more than ₹30,000. Use EXISTS.*/

--- EXISTS-------

SELECT [E1].[Name],[E1].[Department] FROM [Day9Employee] AS [E1]
WHERE EXISTS(
SELECT 1
FROM [Day9Employee] AS [E2]
WHERE [E1].[Department]=[E2].[Department]
AND [E2].[Salary]>30000
);

/*Q21. Display Name and Department for employees whose department has no 
employee earning more than ₹28,000. Use NOT EXISTS.*/

SELECT [e1].[Name],[e1].[Department] FROM [Day9Employee] AS [e1] WHERE NOT EXISTS
( SELECT 1
   FROM [Day9Employee] AS [e2]
   WHERE [e1].[Department]=[e2].[Department]
   AND [e2].[Salary]>28000
)

/*Q22. Display the names and salaries of the five employees with the lowest salaries.
Q23. Display the three oldest employees, showing their names and ages.*/

SELECT TOP 5 [Name],[Salary] FROM [Day9Employee] ORDER BY [Salary] ASC;

SELECT TOP 3 [Name],[Age] FROM [Day9Employee] ORDER BY [Age] DESC;