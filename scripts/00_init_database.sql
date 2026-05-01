/*
=============================================================
			Create a database and tables
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouseAnalytics' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, this script creates the tables and loads data into it.
	
WARNING:
    Running this script will drop the entire 'DataWarehouseAnalytics' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

DROP DATABASE IF EXISTS datawarehouse_analytics;
CREATE DATABASE datawarehouse_analytics;

USE datawarehouse_analytics;

DROP TABLE IF EXISTS dim_customers;
CREATE TABLE dim_customers(
	customer_key int,
	customer_id int,
	customer_number varchar(50),
	first_name varchar(50),
	last_name varchar(50),
	country varchar(50),
	marital_status varchar(50),
	gender varchar(50),
	birthdate date,
	create_date date
);

LOAD DATA LOCAL INFILE "/Users/pradeep/Documents/sql-practice/datawarehouse-analytics/datasets/dim_customers.csv"
INTO TABLE dim_customers
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;


DROP TABLE IF EXISTS dim_products;
CREATE TABLE dim_products(
	product_key int,
	product_id int,
	product_number varchar(50),
	product_name varchar(50),
	category_id varchar(50),
	category varchar(50),
	subcategory varchar(50),
	maintenance varchar(50),
	cost int,
	product_line varchar(50),
	start_date date
);

LOAD DATA LOCAL INFILE "/Users/pradeep/Documents/sql-practice/datawarehouse-analytics/datasets/dim_products.csv"
INTO TABLE dim_products
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;


DROP TABLE IF EXISTS fact_sales;
CREATE TABLE fact_sales(
	order_number varchar(50),
	product_key int,
	customer_key int,
	order_date date,
	shipping_date date,
	due_date date,
	sales_amount int,
	quantity tinyint,
	price int 
);

LOAD DATA LOCAL INFILE "/Users/pradeep/Documents/sql-practice/datawarehouse-analytics/datasets/fact_sales.csv"
INTO TABLE fact_sales
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    order_number,
    product_key,
    customer_key,
    @order_date,
    @shipping_date,
    @due_date,
    sales_amount,
    quantity,
    price
)
SET
    order_date    = NULLIF(@order_date, ''),
    shipping_date = NULLIF(@shipping_date, ''),
    due_date      = NULLIF(@due_date, '');


-- SELECT * FROM dim_customers LIMIT 100;
-- SELECT * FROM dim_products LIMIT 100;
-- SELECT * FROM fact_sales LIMIT 100;

-- SHOW VARIABLES LIKE 'local_infile'; -- to enable load data local infile on server side
