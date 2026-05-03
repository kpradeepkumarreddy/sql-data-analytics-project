/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - To group data into meaningful categories for targeted insights.
    - For customer segmentation, product categorization, or regional analysis.

SQL Functions Used:
    - CASE: Defines custom segmentation logic.
    - GROUP BY: Groups data into segments.
===============================================================================
*/

USE datawarehouse_analytics;

/* Segment products into cost ranges and count how many products fall into each segment */
	
WITH product_segments AS 
(
	SELECT 
		dp.product_name, 
		fs.price,
		CASE 
			WHEN price < 250 THEN 'Cheap'
			WHEN price < 1000 THEN 'Moderate'
			ELSE 'Premium'
	END AS cost_category
	FROM dim_products dp LEFT JOIN fact_sales fs ON dp.product_key=fs.product_key
	GROUP BY dp.product_name, fs.price
)
SELECT 
	cost_category,
	COUNT(product_name) AS total_products
FROM product_segments
GROUP BY cost_category;
	


/* Group customers into three segments based on their spending behavior:
	- VIP: Customers with at least 12 months of history and spending more than €5,000.
	- Regular: Customers with at least 12 months of history but spending €5,000 or less.
	- New: Customers with a lifespan less than 12 months.
And find the total number of customers by each group
*/

WITH customers AS 
(
	SELECT 
		dc.first_name,
		dc.last_name,
		TIMESTAMPDIFF(MONTH, MIN(fs.order_date), MAX(fs.order_date)) AS spend_history_months,
		SUM(fs.sales_amount) AS total_spend 
	FROM dim_customers dc LEFT JOIN fact_sales fs ON dc.customer_key=fs.customer_key
	GROUP BY dc.first_name, dc.last_name
	ORDER BY total_spend DESC
),
customer_catgories AS 
(
	SELECT 
		first_name,
		last_name,
		CASE 
			WHEN spend_history_months > 12 AND total_spend > 5000 THEN 'VIP'
			WHEN spend_history_months >= 12 AND total_spend <= 5000 THEN 'Regular'
			ELSE 'New'
		END AS customer_category
	FROM customers
)
SELECT 
	customer_category,
	COUNT(*) AS total_customers
FROM customer_catgories
GROUP BY customer_category;
