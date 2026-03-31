SET search_path TO sales;
-- USER STORAGE
-- SYSTEM CATALOG
SELECT 
DISTINCT TABLE_NAME
FROM INFORMATION_SCHEMA.COLUMNS;
-- TEMPORARY STORAGE

----- SUBQUERY -----
-- find the products that have a price higher than the average price od all products
SELECT
productid,
price
FROM
(SELECT
	productid,
	price,
	AVG(price) OVER() avgprice
FROM products)
WHERE price > avgprice;

-- rank customersd based on their total amount of sales
SELECT
*,
RANK() OVER (ORDER BY total_sales DESC) customerrank
FROM 
(SELECT
	customerid,
	SUM(sales) as total_sales
FROM orders
GROUP BY customerid) t;

-- \show the productids, product names, prices and the total number of orders
SELECT
	productid,
	product,
	price,
	(SELECT COUNT(*) FROM orders) as totalorders --only allowed to add scalar subquery in select
FROM products;

-- show all customers details and find the total orders from each customer  
SELECT
	*
FROM customers c
LEFT JOIN (
SELECT
	customerid,
	count(*) total_sales
	FROM orders
	GROUP BY customerid
) o
ON c.customerid = o.customerid;
-- find the products that have a price higher than the average price od all products
SELECT
productid,
(SELECT AVG(price) FROM products) as avgprice
FROM products
WHERE price > (SELECT AVG(price) FROM products);
-- show rthe details of orders  made by customers in germany/not made by ...
SELECT
*
FROM orders
WHERE customerid IN --/NOT IN
(
	SELECT
	customerid
	FROM customers
	WHERE country = 'Germany');

-- find female employees whose salaries are greater than the salaries of any male employee
SELECT
	employeeid,
	firstname,
	-- gender,
	salary
FROM employees
WHERE gender = 'F'
AND salary > ANY (SELECT salary FROM employees WHERE gender = 'M');

SELECT
	employeeid,
	firstname,
	-- gender,
	salary
FROM employees
WHERE gender = 'M';

