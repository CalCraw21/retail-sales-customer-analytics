-- data quality and analysis check for sales table
-- 5000 rows
SELECT count(*)
FROM sales;

-- Checking for any null amounts and if the date falls between 2023/1/1 and 2025/12/31
SELECT
	COUNT(*) 							AS total_rows,
	COUNT(order_date) 					AS non_null_rows,
	COUNT(*) - COUNT(order_date) 		AS null_amounts,
	MIN(order_date) 					AS min_date,
	MAX(order_date) 					AS max_date
FROM sales;

-- Checking for any null values in customer_id
SELECT
	COUNT(*) 							AS total_rows,
	COUNT(customer_id) 					AS non_null_rows,
	COUNT(*) - COUNT(customer_id) 		AS null_amounts,
	COUNT(DISTINCT customer_id)			AS unique_ids
FROM sales; -- 793 unique customers

SELECT customer_id
FROM sales
ORDER BY customer_id DESC; --12 records start with '900' instead of '10'

-- checking to see if any records exist in sales table but aren't in customers table
SELECT s.*
FROM sales AS s
LEFT JOIN customers AS c
    ON s.customer_id = c.customer_id
WHERE c.customer_id IS NULL
ORDER BY s.customer_id; -- 12 records, all of which start with '900' we can list these as guest accounts since they don't appear in the customers table

-- checking the number of orders and total items ordered for each customer
SELECT 
	s.customer_id,
	CONCAT(first_name, ' ', last_name) 	AS name,
	COUNT(*) 							AS num, 
	SUM(quantity) 						AS total_quantity
FROM sales AS s
LEFT JOIN customers AS c
	ON s.customer_id = c.customer_id
GROUP BY s.customer_id, name
ORDER BY num DESC, total_quantity DESC; -- customer 100002 has 125 orders with 314 item, the most by far

-- Checking for null values in product_id
SELECT
	COUNT(*) 							AS total_rows,
	COUNT(product_id) 					AS non_null_rows,
	COUNT(*) - COUNT(product_id) 		AS null_amounts,
	COUNT(DISTINCT product_id)			AS unique_ids
FROM sales; -- 129 unique product ids

SELECT product_id
FROM sales
ORDER BY product_id DESC; -- 9 records begin with '800' instead of '20'

-- checking to see if any records exist in sales table but aren't in products table
SELECT s.*
FROM sales AS s
LEFT JOIN products AS p
	ON s.product_id = p.product_id
WHERE p.product_id IS NULL
ORDER BY s.product_id; -- The same 9 records from before, product that exist in the sale table and not product table

-- checking how many times a product was part of an order and the total amount ordered
SELECT 
	s.product_id, 
	product_name 	AS name, 
	COUNT(s.*) 		AS num, 
	SUM(quantity) 	AS total_quantity
FROM sales AS s
LEFT JOIN products AS p
	ON s.product_id = p.product_id
GROUP BY s.product_id, product_name
ORDER BY total_quantity DESC, num DESC; -- product_id 200537 was included in 58 orders and was ordered the most at 178 times

-- Checking for null records in quantity and looking at the largest order
SELECT 
	COUNT(*) 							AS total_rows,
	COUNT(quantity) 					AS non_null_rows,
	COUNT(*) - COUNT(quantity) 			AS null_amounts,
	MAX(quantity)						AS biggest_order,
	MIN(quantity)						AS smallest_order
FROM sales; -- largets order was 10

SELECT *
FROM sales
LIMIT 10;