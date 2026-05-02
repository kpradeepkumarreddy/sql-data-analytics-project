/*
===============================================================================
Performance Analysis (Year-over-Year, Month-over-Month)
===============================================================================
Purpose:
    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track yearly trends and growth.

SQL Functions Used:
    - LAG(): Accesses data from previous rows.
    - AVG() OVER(): Computes average values within partitions.
    - CASE: Defines conditional logic for trend analysis.
===============================================================================
*/


USE datawarehouse_analytics;

/* 
 	Analyze the yearly performance of products by comparing their sales 
	to both the average sales performance of the product and the previous year's sales 
*/

WITH yearly_sales AS
(
	SELECT 
		dp.product_name,
		YEAR(fs.order_date) AS order_year,
		SUM(fs.sales_amount) AS current_sales
	FROM dim_products AS dp LEFT JOIN fact_sales fs ON dp.product_key = fs.product_key
	WHERE fs.order_date IS NOT NULL
	GROUP BY dp.product_name, order_year
	ORDER BY dp.product_name
)
SELECT 
	product_name,
	order_year,
	current_sales,
	ROUND(AVG(current_sales) OVER(PARTITION BY product_name), 2) AS avg_sales,
	current_sales - ROUND(AVG(current_sales) OVER(PARTITION BY product_name), 2) AS avg_sales_diff,
	CASE 
		WHEN current_sales - ROUND(AVG(current_sales) OVER(PARTITION BY product_name), 2) < 0 THEN 'Below Average'
		WHEN current_sales - ROUND(AVG(current_sales) OVER(PARTITION BY product_name), 2) > 0 THEN 'Above Average'
		ELSE 'Average'
	END AS sales_performance,
	-- year-over-year analysis
	LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) AS prev_year_sales,
	current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) AS prev_sales_diff,
	CASE 
		WHEN current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decreased'
		WHEN current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increased'
		ELSE 'Same'
	END AS yoy_sales_performance
FROM yearly_sales;
