/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: RANK(), DENSE_RANK(), ROW_NUMBER(), TOP
    - Clauses: GROUP BY, ORDER BY
===============================================================================
*/

USE datawarehouse_analytics;


-- Which 5 products Generating the Highest Revenue?
-- Simple Ranking
SELECT dp.product_name, SUM(fs.sales_amount) AS total_revenue FROM fact_sales fs  
LEFT JOIN dim_products dp ON dp.product_key=fs.product_key
GROUP BY dp.product_name
ORDER BY total_revenue DESC 
LIMIT 5;


-- Complex but Flexibly Ranking Using Window Functions
SELECT * FROM 
(
	SELECT 
		dp.product_name, 
		SUM(fs.sales_amount) AS total_revenue, 
		RANK() OVER(ORDER BY SUM(fs.sales_amount) DESC) AS revenue_rank
	FROM fact_sales fs  
	LEFT JOIN dim_products dp ON dp.product_key=fs.product_key
	GROUP BY dp.product_name
	ORDER BY total_revenue DESC
)t  
WHERE revenue_rank < 6; 


-- What are the 5 worst-performing products in terms of sales?
SELECT dp.product_name, SUM(fs.sales_amount) AS total_revenue FROM fact_sales fs  
LEFT JOIN dim_products dp ON dp.product_key=fs.product_key
GROUP BY dp.product_name
ORDER BY total_revenue 
LIMIT 5;


-- Find the top 10 customers who have generated the highest revenue
SELECT dc.customer_key, dc.first_name, dc.last_name, SUM(fs.sales_amount) AS total_revenue FROM dim_customers dc  
LEFT JOIN fact_sales fs ON dc.customer_key=fs.customer_key
GROUP BY dc.customer_key, dc.first_name, dc.last_name 
ORDER BY total_revenue DESC
LIMIT 10;


-- The 3 customers with the fewest orders placed
select dc.customer_key, dc.first_name, dc.last_name, COUNT(DISTINCT fs.order_number) AS total_orders from dim_customers dc 
LEFT JOIN fact_sales fs ON dc.customer_key=fs.customer_key
GROUP BY dc.customer_key, dc.first_name, dc.last_name 
ORDER BY total_orders, first_name, last_name
LIMIT 3;

