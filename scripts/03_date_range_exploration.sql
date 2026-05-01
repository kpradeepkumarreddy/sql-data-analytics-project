/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), TIMESTAMPDIFF()
===============================================================================
*/


-- Determine the first and last order date and the total duration in months
SELECT 
	MIN(order_date) AS first_order_date,
	MAX(order_date) AS last_order_date,
	TIMESTAMPDIFF(MONTH, MIN(order_date), MAX(order_date)) AS order_date_range
FROM datawarehouse_analytics.fact_sales;



-- Find the youngest and oldest customer based on birthdate
SELECT
	TIMESTAMPDIFF(YEAR, MAX(order_date), CURDATE()) AS youngest_customer,
	TIMESTAMPDIFF(YEAR, MIN(order_date), CURDATE()) AS oldest_customer
FROM datawarehouse_analytics.fact_sales;



-- help TIMESTAMPDIFF;
-- help now;
-- help curdate;
-- help datediff;
-- SELECT CURDATE();
