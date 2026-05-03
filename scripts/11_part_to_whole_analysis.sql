/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - To compare performance or metrics across dimensions or time periods.
    - To evaluate differences between categories.
    - Useful for A/B testing or regional comparisons.

SQL Functions Used:
    - SUM(), AVG(): Aggregates values for comparison.
    - Window Functions: SUM() OVER() for total calculations.
===============================================================================
*/

USE datawarehouse_analytics;

-- Which categories contribute the most to overall sales?
WITH product_category_revenues AS 
(
	SELECT 
		dp.category, 
		SUM(fs.sales_amount) AS category_revenue 
	FROM fact_sales fs LEFT JOIN dim_products dp ON dp.product_key=fs.product_key
	GROUP BY dp.category
	ORDER BY category_revenue DESC
)
SELECT 
	category,
	category_revenue,
	ROUND((category_revenue/SUM(category_revenue) OVER())*100, 2) AS revenue_contribution
FROM product_category_revenues;

