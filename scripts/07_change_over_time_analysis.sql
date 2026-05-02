/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

SQL Functions Used:
    - Date Functions: YEAR(), MONTH(), DATE_FORMAT()
    - Aggregate Functions: SUM()
===============================================================================
*/

USE datawarehouse_analytics;

-- Analyse sales performance over time
-- Quick Date Functions
select YEAR(order_date) AS sales_year, SUM(sales_amount) AS total_sales from fact_sales
WHERE order_date IS NOT NULL
GROUP BY sales_year
ORDER BY sales_year;


select YEAR(order_date) AS sales_year, MONTH(order_date) AS sales_month, SUM(sales_amount) AS total_sales from fact_sales
WHERE order_date IS NOT NULL
GROUP BY sales_year, sales_month
ORDER BY sales_year, sales_month;



-- truncate to month
-- DATE_FORMAT(order_date, '%Y-%m-01')

select DATE_FORMAT(order_date, '%Y-%m-01') AS sale_month, SUM(sales_amount) AS total_sales from fact_sales
WHERE order_date IS NOT NULL
GROUP BY sale_month
ORDER BY sale_month;


-- truncate to year
-- DATE_FORMAT(order_date, '%Y-01-01')

select DATE_FORMAT(order_date, '%Y-01-01') AS sale_year, SUM(sales_amount) AS total_sales from fact_sales
WHERE order_date IS NOT NULL
GROUP BY sale_year
ORDER BY sale_year;



help date_format;

-- %Y - 4-digit year
-- %y - 2-digit year
-- %m - month number
-- %b - short month name
-- %M - full month name
-- %d - day

select DATE_FORMAT(order_date, '%Y-%b') AS sale_month, SUM(sales_amount) AS total_sales from fact_sales
WHERE order_date IS NOT NULL
GROUP BY sale_month


