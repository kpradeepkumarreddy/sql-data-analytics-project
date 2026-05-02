/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
===============================================================================
*/


USE datawarehouse_analytics;


-- Calculate the total sales per year 
-- and the running total of sales over time 
SELECT 
	sales_year,
	total_sales,
	SUM(total_sales) OVER(ORDER BY sales_year) AS running_total_sales
FROM	
(
	SELECT 
		YEAR(order_date) AS sales_year, 
		SUM(sales_amount) AS total_sales 
	FROM fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY sales_year
)t;


-- Calculate the total sales per year per month 
-- and the running total of sales over time 
SELECT 
	sale_year_month,
	total_sales,
	SUM(total_sales) OVER(PARTITION BY YEAR(sale_year_month) ORDER BY sale_year_month) AS running_total_sales
FROM	
(
	SELECT 
		DATE_FORMAT(order_date, '%Y-%m-01') AS sale_year_month, 
		SUM(sales_amount) AS total_sales 
	FROM fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY sale_year_month
)t;


-- and moving average price
SELECT 
	sales_year,
	total_sales,
	SUM(total_sales) OVER(ORDER BY sales_year) AS running_total_sales,
	average_price,
	ROUND(AVG(average_price) OVER(ORDER BY sales_year), 2) AS moving_average_price
FROM	
(
	SELECT 
		YEAR(order_date) AS sales_year, 
		SUM(sales_amount) AS total_sales,
		ROUND(AVG(price), 2) AS average_price
	FROM fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY sales_year
)t;
