-- 01_data_exploration
-- Purpose: Explore the retail analytics dataset.

-- 1. Preview the sales data
SELECT *
FROM sales
LIMIT 10;

-- 2. Preview the customer data
SELECT *
FROM customers
LIMIT 10;

-- 3. Preview the product data
SELECT *
FROM products
LIMIT 10;

-- 4. Check the date range of the sales data
SELECT
	MIN(order_date) AS earliest_order_date,
	MAX(order_date) AS latest_order_date
FROM sales;

-- 5. Check the different order statuses
SELECT DISTINCT order_status
FROM sales
ORDER BY order_status;

-- 6. Check the different sales channels
SELECT DISTINCT sales_channel
FROM sales
ORDER BY sales_channel;

-- 7. Check the different product categories
SELECT DISTINCT category
FROM products
ORDER BY category;

-- 8. Check the different customer segments
SELECT DISTINCT customer_segment
FROM customers
ORDER BY customer_segment;