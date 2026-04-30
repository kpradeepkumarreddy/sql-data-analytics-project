/*
===============================================================================
Database Exploration
===============================================================================
Purpose:
    - To explore the structure of the database, including the list of tables and their schemas.
    - To inspect the columns and metadata for specific tables.

Table Used:
    - INFORMATION_SCHEMA.TABLES
    - INFORMATION_SCHEMA.COLUMNS
===============================================================================
*/

-- Retrieve a list of all tables in the database
SELECT * FROM INFORMATION_SCHEMA.TABLES;


SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME LIKE 'dim%' OR TABLE_NAME LIKE 'fact%';


-- Retrieve all columns for a specific table (dim_customers)
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE, CHARACTER_MAXIMUM_LENGTH FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'dim_customers';
