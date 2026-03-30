-- find all orders where sales are higher than the average sales across all orders
SELECT
*
FROM
(SELECT
	OrderID,
	ProductID,
	Sales,
	AVG(sales) OVER() AS AvgSales
FROM Sales.Orders) t
WHERE Sales > AvgSales;
-- find highest/lowest sales across all orders/for each product/ also provide additional info:orderid, orderdate
SELECT
	OrderID,
	OrderDate,
	ProductID,
	MAX(Sales) OVER() AS HighestSales,
	MIN(Sales) OVER() AS LowestSales,
	MAX(Sales) OVER(PARTITION BY ProductID) AS HighestSalesByProduct,
	MIN(Sales) OVER(PARTITION BY ProductID) AS LowestSalesByProduct
FROM Sales.Orders;
----- show the employees with the highest salaries
-- SET search_path TO sales;

SELECT
*
FROM
(SELECT
*,
MAX(salary) OVER() AS highest_salary
FROM employees) t
WHERE salary = highest_salary;
-- calculate the deviation of each sale from both the minimum and maximum sales amounts

SELECT
	OrderID,
	OrderDate,
	ProductID,
	MAX(Sales) OVER() AS HighestSales,
	MIN(Sales) OVER() AS LowestSales,
	Sales - MIN(Sales) OVER() AS deviationfrommin,
	MAX(Sales) OVER() - Sales AS deviationfrommax
FROM orders;

-- calculate moving average of sales fro each product over time
-- calculate moving average of sales fro each product over time, including only the next order
SELECT
	OrderID,
	ProductID,
	OrderDate,
	Sales,
	AVG(Sales) OVER(PARTITION BY ProductID) AvgByPrdct,
	AVG(Sales) OVER(PARTITION BY ProductID Order By OrderDate) AS MovingAvg,
	AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS RollingAvg
FROM orders;
-- rank the orders based on their sales from higehst to lowest
SELECT
	orderid,
	productid,
	sales,
	ROW_NUMBER() OVER(ORDER BY sales DESC) as salesrank_row,
	RANK() OVER(ORDER BY sales DESC) as salesrank_rank,
	DENSE_RANK() OVER(ORDER BY sales DESC) as salesrank_dense
FROM orders;
-- find the top highest sales for each product
SELECT
*
FROM
(SELECT
	orderid,
	productid,
	sales,
	ROW_NUMBER() OVER (PARTITION BY productid ORDER BY sales DESC) AS rankbyproduct
FROM orders) t
WHERE rankbyproduct = 1;

-- find the lowest 2 customers based on their total sales
SELECT * FROM
(SELECT
	customerid,
	SUM(sales) as total_sales,
	ROW_NUMBER() OVER (ORDER BY	SUM(sales)) AS RankCustomers
FROM orders
GROUP BY customerid) t
WHERE RankCustomers <= 2;
-- assign uniquq ids to the rows of the ordersarchive
SELECT
ROW_NUMBER() OVER(ORDER BY orderid) AS id,
*
FROM ordersarchive;
-- in this table remove dublicates
SELECT * FROM 
(SELECT
	ROW_NUMBER() OVER(PARTITION BY orderid ORDER BY creationtime) as rn,
	*
FROM ordersarchive) t
where rn > 1;
-- segment all orders into 3 categories: high, medium, low
SELECT
orderid,
CASE 
	WHEN Buckets = 1 THEN 'High'
	WHEN Buckets = 2 THEN 'Medium'
	WHEN Buckets = 3 THEN 'Low'
END AS SalesSegmentation
FROM (SELECT
	orderid,
	sales,
	NTILE(3) OVER(ORDER BY Sales DESC) buckets
FROM orders) t;
-- in order to export the data divide the orders into 2 groups
SELECT
	NTILE(2) OVER(ORDER BY ORDERID) as buckets
FROM orders;
-- find the products that fall within highest 40% of prices
SELECT
*,
CONCAT(distrank * 100, '%')
FROM
(SELECT
product,
price,
CUME_DIST() OVER(ORDER BY price) AS distrank
FROM products) t
WHERE distrank <= 0.4;
-- analyze MoM performance by finding the percantage change in sales between the current and previous month
-- time series analysis
SELECT
	*,
	current_month_sales - previous_month_sales AS MoM_Change,
	ROUND(CAST((current_month_sales - previous_month_sales) * 100.0 / previous_month_sales AS NUMERIC), 1)
FROM
(SELECT
	EXTRACT(MONTH FROM OrderDate) AS ordermonth,
	SUM(sales) AS current_month_sales,
	LAG(SUM(sales)) OVER(ORDER BY EXTRACT(MONTH FROM OrderDate)) AS previous_month_sales
FROM orders
	group by EXTRACT (MONTH FROM OrderDate))
