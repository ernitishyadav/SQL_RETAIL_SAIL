# SQL_RETAIL_SAIL

## Project Overview
<h4>Poject Title: Retail_sail_analysis</h4>
<h4>Level: Beginner</h4>
<h4>Database: Retail_analysis</h4>
<p>This project is designed to demonstrate SQL skills and technique typically used by data analyst to explore,clean and analyse the retail sales data.
This project involves setting up of a retail sales database ,performing Exploratry Database Analysis(EDA), and answering specific business question through 
SQL queries</p>


## Objective
<ol>
  <li>Setup a retail sales database: Create and populate a retail sales database with the provided sales data</li>
  <li>Data Cleaning: Identify and remove any missing or null values </li>
  <li>Exploratry Database Analysis(EDA): Perform basic exploratry data analysis to understand the database</li>
  <li>Busniess analysis: SQL to answer the business query</li>
</ol>

## Creating database 
```SQL
CREATE DABASE IF NOT EXISTS retail_analysis;
USE retail_analysis;
```
## Creating Table

```SQL
CREATE TABLE IF NOT EXISTS sales(
transactions_id INT,
sale_date VARCHAR(30),
sale_time VARCHAR(30),
customer_id INT,
gender VARCHAR(8),
age varchar (20),
category VARCHAR(30),
quantity	VARCHAR(10),
price_per_unit VARCHAR(40),	
cogs VARCHAR(30),
total_sale VARCHAR(30)
);
```
```SQL
## INSERTING DATA INTO TABLE
LOAD DATA INFILE 'C:/RETAIL SALES.csv'
into table sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES terminated by '\n'
IGNORE 1 ROWS;

```
```SQL
## EDA
SELECT * FROM sales WHERE
 transactions_id IS NULL OR transactions_id = '' OR
    sale_date IS NULL OR sale_date = '' OR
    sale_time IS NULL OR sale_time = '' OR
    customer_id IS NULL OR customer_id = '' OR
    gender IS NULL OR gender = '' OR
    category IS NULL OR category = '' OR
    quantity IS NULL OR quantity = '' OR
    price_per_unit IS NULL OR price_per_unit = '' OR
    cogs IS NULL OR cogs = '' OR
    total_sale IS NULL OR total_sale = '';
```
```SQL
## DATA CLEANING
delete from sales
WHERE 
    transactions_id IS NULL OR transactions_id = '' OR
    sale_date IS NULL OR sale_date = '' OR
    sale_time IS NULL OR sale_time = '' OR
    customer_id IS NULL OR customer_id = '' OR
    gender IS NULL OR gender = '' OR
    category IS NULL OR category = '' OR
    quantity IS NULL OR quantity = '' OR
    price_per_unit IS NULL OR price_per_unit = '' OR
    cogs IS NULL OR cogs = '' OR
    total_sale IS NULL OR total_sale = '';

	SET SQL_SAFE_UPDATES = 0;
```
##   -- DATA ANALYSIS AND FINDING INSIGHT
<P>1 Write A sql query to retrive all columns for sale on made on '2022-11-05'</P>
```SQL
               SELECT * FROM sales where sale_date = '2022-11-05';
```

