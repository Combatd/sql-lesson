-- Previewing Data 

SELECT * FROM Sales;

SELECT		date, county, category_name
FROM		sales
LIMIT 		100; 

SELECT		vendor
FROM		Sales;

SELECT DISTINCT vendor FROM sales

SELECT		DISTINCT vendor, category_name 
FROm 		Sales
ORDER BY 2

SELECT 	DISTINCT date 
FROM 		Sales

--Filtering Using Where Clause 

--TEXT 

SELECT		*
FROM		sales
WHERE		lower(county) = 'scott' OR county = 'Polk' OR county = 'Dallas'

--NUMERIC

SELECT * FROM Sales 

SELECT 		*
FROM 			sales
WHERE			category_name LIKE '%VODKA%'

SELECT 		*
FROM 			sales
WHERE			category_name NOT LIKE '%VODKA%' 

--Aggregate functions 

SELECT		*
FROM 		sales

SELECT SUM(total) FROM sales 

SELECT 	vendor, SUM(total) 
FROM 		sales
GROUP BY vendor 
ORDER BY 2 desc

SELECT vendor, category_name, SUM(total)
FROM sales
GROUP BY vendor, category_name

SELECT SUM(total), COUNT(total), AVG(total), MIN(total), MAX(total)
From Sales 

SELECT county, SUM(total) as total_sales, COUNT(total), ROUND(AVG(total), 2), MIN(total), MAX(total)
From sales
Group by 1 --1

-- using Count()
SELECT COUNT(*) FROM sales -- how manny rows are in this table? 
SELECT COUNT(category_name) FROM sales 
SELECT COUNT(DISTINCT category_name) FROM sales


-- Practice 1) AOV for Bacardi Categories 
SELECT 		category_name, AVG(total) as avg_total 
FROM			sales
WHERE 			vendor LIKE '%Bacardi%'
GROUP BY		category_name
ORDER BY 	AVG(total) desc

-- Practice 2) 
SELECT 	vendor, COUNT(DISTINCT category_name) as distinct_total
FROM		Sales 
GROUP BY 1
ORDER BY distinct_total desc

SELECT 	vendor, COUNT(DISTINCT category_name) as distinct_total
FROM		Sales 
GROUP BY 1
HAVING	COUNT(distinct category_name) > 20
ORDER BY distinct_total desc

-- CASE Statements - Transaction Bin 

SELECT     CASE WHEN total < 100 THEN 'Small'
						  WHEN total < 500 THEN 'Medium'
						  ELSE 'Large'  END as total_bin
				, COUNT(*)
FROM		Sales
GROUP BY 1

SELECT * FROM Sales

-- Create a category_group fro VODKA, RUM, SCOTCH categories 

SELECT		category_name
				,CASE WHEN category_name LIKE '%VODKA%' THEN 'VODKA'
						 WHEN category_name LIKE '%RUM%' THEN 'RUM'
						 WHEN category_name LIKE '%SCOTCH%' THEN 'SCOTCH'
						 ELSE 'OTHER' END
FROM		SALES

SELECT		CASE WHEN category_name LIKE '%VODKA%' THEN 'VODKA'
						 WHEN category_name LIKE '%RUM%' THEN 'RUM'
						 WHEN category_name LIKE '%SCOTCH%' THEN 'SCOTCH'
						 ELSE 'OTHER' END as category_group
				,ROUND(SUM(total), 0)
FROM		SALES
GROUP BY 1

-- Calculation Over Fields

SELECT * From Sales 

SELECT btl_price * bottle_qty as total_check, total
FROM sales

--Joining Tables
SELECT * FROM sales
SELECT * FROM counties

SELECT		*
FROM		sales
LEFT JOIN	counties
ON			sales.county = counties.county 

SELECT		*
FROM		sales as a
LEFT JOIN 	counties as b
ON			a.county = b.county 

SELECT		date, a.county, population, total
FROM 		sales as a
LEFT JOIN	counties as b
ON			a.county = b.county

-- Join all the tables to the Sales tables: Stores, Counties, Products 

SELECT		*
FROM		sales as a
LEFT JOIN 	Counties as b
ON			a.county = b.county
LEFT JOIN 	stores as c 
ON			a.store = c.store
LEFT JOIN 	products as d
ON			a.item = d.item_no

SELECT a.name, SUM(b.total)
FROM 	stores as a 
LEFT JOIN sales as b
ON	a.store = b.store
GROUP BY 1
ORDER BY 2 desc

SELECT a.proof, COUNT(*) as total_transactions 
FROM sales as b
LEFT JOIN products as a
ON a.item_no = b.item
GROUP BY 1
ORDER BY 2 desc

SELECT 				*
FROM					sales as a 
LEFT JOIN				products as d
ON						a.item = d.item_no
WHERE					d.item_no IS NULL 

SELECT * FROM Products WHERE item_no = 80487
-- 34008 

SELECT * 
FROM sales
WHERE item  = 34008
--49 ROWS

SELECT * 
FROM products
WHERE item_no = 34008
-1 row 

SELECT 				* 
FROM 					products as a
INNER JOIN			Sales as b 
ON						a.item_no = b.item
WHERE					item_no = 34008 

SELECT * FROM sales
SELECT * FROM products 

SELECT COUNT(*) FROM Products 


-- Union 

SELECT *
FROM fy17p

UNION

SELECT * 
FROM	fy18p
--Subquery 

SELECT 		*
FROM
(SELECT * FROM Stores LIMIT 5)

-- CTE 
WITH sales_per_county as 
(
SELECT 		county, SUM(total) as total_sales
FROM 			sales
GROUP BY 	1
),

sales_per_county_population as 
(
SELECT a.county, a.total_sales, b.population
FROM sales_per_county as a 
INNER JOIN Counties as b
ON a.county = b.county
)

SELECT 		*, ROUND(total_sales / population, 2) as sales_per_person 
FROM			sales_per_county_population
ORDER BY 	sales_per_person desc 