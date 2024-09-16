CREATE DATABASE IF NOT EXISTS retail_analysis;
USE retail_analysis;

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
drop table sales;
LOAD DATA INFILE 'C:/RETAIL SALES.csv'
into table sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES terminated by '\n'
IGNORE 1 ROWS;

-- //DATA CLEANING


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
    
SET SQL_SAFE_UPDATES = 0;
        
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
    
    
    -- DATA ANALYSIS AND FINDING INSIGHT
    
 --      1 Write A sql query to retrive all columns for sale on made on '2022-11-05'
--      2 Write a sql query to retrieve all the transaction where the category is 'clothing' and 
--      the quantity sold is more than 10 in the month of Nov-2022
-- 	    3 Write a sql query to calcualte the total sales (total_sales) for each category.
--      4. write a sql query to find the avgerage age of customer who purchased items from the beauty category
--      5. write a sql query to find total number of transaction where the total_sale is greater than 1000.
-- 	    6.write a query to find the total number of transaction(transaction_id) made by each gender in each category
--       7.write a sql query to calculate the average sale for each month. find out best selling month in each year
--       8. write a sql query to find the top 5 customer's based on the total sales
--       9. write a sql query to find the numbe rof unique coustomers who purchased items from each category
--       10 write a sql query to create each shift and number of orders (example Morning <=12, Afternoon Between 12 & 17 , EVENING >17);
   
         --  1 Write A sql query to retrive all columns for sale on made on '2022-11-05'
               SELECT * FROM sales where sale_date = '2022-11-05';
   

          -- 2 Write a sql query to retrieve all the transaction where the category is 'clothing' and 
		  --  the quantity sold is more than 4 in the month of Nov-2022 
          
           
SELECT *
FROM sales 
WHERE category = 'clothing' 
AND YEAR(sale_date) = 2022 
AND MONTH(sale_date) = 11
AND quantity >=4;

--  3 Write a sql query to calcualte the total sales (total_sales) for each category.

SELECT * 
FROM sales;
SELECT category, 
SUM(total_sale) AS net_sales,
COUNT(*) AS total_order
FROM sales 
GROUP BY 1;


--  4. write a sql query to find the avgerage age of customer who purchased items from the beauty category

SELECT 
ROUND(AVG(age),2) AS avg_age
FROM sales 
WHERE category = "beauty";

-- 5. write a sql query to find total number of transaction where the total_sale is greater than 1000.

SELECT 
COUNT(transactions_id) as transaction_no 
FROM sales
WHERE total_sale >1000;

-- 6.write a query to find the total number of transaction(transaction_id) made by each gender in each category

SELECT
gender,
category ,
COUNT(*)
FROM sales
GROUP BY 1,2
ORDER BY 2;

--       7.write a sql query to calculate the average sale for each month. find out best selling month in each year

SELECT * FROM 
(
SELECT 
    YEAR(sale_date) AS `YEAR`,
    MONTH(sale_date) AS `MONTH`,
    AVG(total_sale) AS avg_sale,
    RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS sale_rank
FROM sales
GROUP BY YEAR(sale_date), MONTH(sale_date)
) as t1
WHERE sale_rank = 1;

--       8. write a sql query to find the top 5 customer's based on the total sales
SELECT
customer_id,
SUM(total_sale) as total_sale
FROM sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- 9. write a sql query to find the number of unique coustomers who purchased items from each category

 select 
 COUNT(DISTINCT customer_id) AS cnt_unique_ci,
 category 
 from sales 
 group by 2;

-- 10 write a sql query to create each shift and number of orders (example Morning <=12, Afternoon Between 12 & 17 , EVENING >17);
WITH hourly_sale
AS
(
SELECT * ,
CASE 
WHEN HOUR(sale_time) <=12 THEN "Morning"
WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN "Afternoon"
ELSE "EVENING"
END AS SHIFT
FROM sales
)
SELECT 
shift ,
COUNT(*) as total_Sale
 FROM hourly_sale 
 GROUP BY 1;
 
 
 
 -- END OF THE PROJECT