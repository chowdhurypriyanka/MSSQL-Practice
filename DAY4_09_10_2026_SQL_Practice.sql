USE MyFirstDB;
GO

CREATE TABLE dbo.Day4Products
(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    category VARCHAR(30) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    voc_level_g_l INT NOT NULL
);
GO

INSERT INTO dbo.Day4Products
    (product_id, product_name, category, price, voc_level_g_l)
VALUES
    (1, 'Eco Coat',      'Exterior', 500.00, 120),
    (2, 'Aqua Shield',   'Interior', 350.00,  35),
    (3, 'Matte Finish',  'Interior', 420.00,  65),
    (4, 'Weather Guard', 'Exterior', 600.00,  80),
    (5, 'Gloss Plus',    'Wood',     300.00,  25),
    (6, 'Primer Pro',    'Primer',  250.00, 110),
    (7, 'ColorMax',      'Interior', 450.00,  55),
    (8, 'Velvet Touch',  'Wood',     380.00,  45);

    SELECT * FROM [Day4Products] 
    ORDER BY [product_id];

    SELECT COUNT(*) AS [product_count] FROM [Day4Products];
    --Q2. Count the products whose voc_level_g_l is greater than 50. 
    --Name the output column products_above_50_voc.
    SELECT COUNT(*) AS [products_above_50_voc] FROM [Day4Products] WHERE [voc_level_g_l] >50;

    SELECT SUM([price]) AS [total_product_price] FROM [Day4Products];

    --Write a query to calculate the total price of only the products in the Interior category. 
    --Name the result column interior_total_price.
SELECT SUM([price]) AS [interior_total_price] FROM [Day4Products] WHERE [category] = 'Interior';

SELECT AVG([price]) AS [average_product_price] FROM [Day4Products];
--Q6. Calculate the average price of products belonging to the Wood category.
--Name the result column wood_average_price.
SELECT AVG([price]) AS [wood_average_price] FROM [Day4Products] WHERE [category] = 'Wood';
-------------------------------------------
SELECT MIN([price]) AS [minimum_price] FROM [Day4Products];
SELECT MAX([price]) AS [interior_max_price] FROM [Day4Products] WHERE [category] = 'Interior';

SELECT [category], COUNT(*) AS [total_products] FROM [Day4Products] GROUP BY [category];
--Q10. Calculate the total price for each category. Name the result column category_total_price
SELECT [category], SUM([price]) AS [category_total_price] FROM [Day4Products] GROUP BY [category];

SELECT [category], SUM([price]) AS [category_total_price] FROM [Day4Products] GROUP BY [category]
HAVING SUM([price]) >500;

--Q12. Display each category and its product count, but show only categories having at least 2 products.
SELECT [category], COUNT(*) AS [product_count] FROM [Day4Products] GROUP BY [category] 
HAVING COUNT(*) >=2;

--Find categories whose total price is greater than 500, considering only products priced above 350.
SELECT [category], SUM([price]) AS [category_total_price] FROM [Day4Products] 
WHERE [price]>300 GROUP BY [category] HAVING SUM([price]) >=500;

--Q14. Count products in each category, considering only products whose voc_level_g_l is greater than 50.
--Display only categories with at least 2 qualifying products.
SELECT * FROM [Day4Products];
SELECT [category], COUNT(*) AS [product_count] FROM [Day4Products] WHERE [voc_level_g_l]>50 
GROUP BY [category] HAVING COUNT(*) >=2;

CREATE TABLE dbo.Day4TeamA
(
    person_name VARCHAR(50)
);

CREATE TABLE dbo.Day4TeamB
(
    person_name VARCHAR(50)
);

INSERT INTO dbo.Day4TeamA (person_name)
VALUES
('Priya'),
('Rahul'),
('Amit');

INSERT INTO dbo.Day4TeamB (person_name)
VALUES
('Rahul'),
('Neha'),
('Priya');

SELECT [person_name] FROM [Day4TeamA]
UNION
SELECT [person_name] FROM [Day4TeamB];

SELECT [person_name] FROM [Day4TeamA]
UNION ALL 
SELECT [person_name] FROM [Day4TeamB];

SELECT [person_name] FROM [Day4TeamA]
INTERSECT
SELECT [person_name] FROM [Day4TeamB];

SELECT [person_name] FROM [Day4TeamB]
EXCEPT 
SELECT [person_name] FROM [Day4TeamA];
---------------------------------------------------------------------------------
/*Question 1 of 10
Medium
Topics: WHERE + GROUP BY + HAVING + COUNT
Using Day4Products, write a SQL query to:
1. Consider only products whose voc_level_g_l is greater than 50.
2. Group the remaining products by category.
3. Count the products in each category.
4. Display only categories having at least 2 qualifying products.
Your output columns should be:
category and product_count*/

SELECT [category], COUNT(*)AS [product_count] FROM [Day4Products] WHERE [voc_level_g_l]>50 
GROUP BY [category] HAVING COUNT(*) >=2 ;

/*Question 2 of 10 — 
Medium
Using Day4Products, write a query to:
1. Consider only products with a price greater than 300.
2. Group the remaining products by category.
3. Calculate the total price for each category.
4. Display only categories whose total price is at least 500.
Your output columns should be category and category_total_price.*/

SELECT [category], SUM([price]) AS [category_total_price] FROM [Day4Products] WHERE [price] >300
GROUP BY [category] HAVING SUM([price]) >=500;

/*Using Day4Products, write a query to calculate the average price of products in the Wood category.
Your output column should be named wood_average_price*/

SELECT [category], AVG([price]) AS [wood_average_price] FROM [Day4Products] 
WHERE [category] = 'Wood' GROUP BY [category];

/* Using Day4Products, write a query to display the minimum and maximum prices of Interior products.
Your output columns should be:
- minimum_price
- maximum_price*/
SELECT [category], MIN([price]) AS [minimum_price] FROM [Day4Products] 
WHERE [category] = 'Interior' GROUP BY [category] 

SELECT [category], MAX([price]) AS [maximum_price] FROM [Day4Products] WHERE [category] ='Interior'
GROUP BY [category];

/* Using your Day4Products table, write a query to:
1. Group products by category.
2. Calculate the average price for each category.
3. Display only categories whose average price is between 350 and 450, inclusive.*/

SELECT [category], AVG([price]) AS [Avg_price] FROM [Day4Products] GROUP BY [category] HAVING 
AVG([price]) >=350 AND AVG([price]) <=450;

/*Using Day4Products, write a query to:
1. Consider only products with price > 300.
2. Group them by category.
3. Calculate the average price of each category, naming it average_price.
4. Show only categories whose average price is greater than 400.
5. Sort the final result by average_price in descending order.*/

SELECT [category], AVG([price]) AS [average_price] FROM [Day4Products] WHERE [price]>300
GROUP BY [category] HAVING AVG([price]) > 400 ORDER BY [average_price] DESC; 
