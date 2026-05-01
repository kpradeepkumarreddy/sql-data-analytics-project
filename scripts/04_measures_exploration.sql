/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/

USE datawarehouse_analytics;

-- Find the Total Sales
SELECT SUM(sales_amount) AS total_sales FROM fact_sales;


-- Find how many items are sold
SELECT SUM(quantity) AS items_sold FROM fact_sales;


-- Find the average selling price
SELECT AVG(price) AS average_selling_price FROM fact_sales;


-- Find the Total number of orders
SELECT COUNT(DISTINCT order_number) AS total_orders FROM fact_sales;


-- Find the total number of products
SELECT COUNT(product_id) AS total_products FROM dim_products;


-- Find the total number of customers
SELECT COUNT(customer_id) AS total_customers FROM dim_customers;


-- Find the total number of customers who have placed an order
SELECT COUNT(DISTINCT customer_key) AS total_customers_placed_order FROM fact_sales;


-- Generate a Report that shows all key metrics of the business
SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM fact_sales
UNION ALL
SELECT 'Total Quantity', SUM(quantity) FROM fact_sales
UNION ALL
SELECT 'Average Price', AVG(price) FROM fact_sales
UNION ALL
SELECT 'Total Orders', COUNT(DISTINCT order_number) FROM fact_sales
UNION ALL
SELECT 'Total Products', COUNT(DISTINCT product_id) FROM dim_products
UNION ALL
SELECT 'Total Customers', COUNT(customer_key) FROM dim_customers;

