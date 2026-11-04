-- Checking row counts
SELECT 'sales' AS tbl, COUNT(*) AS row_count FROM sales
UNION ALL SELECT 'customers', COUNT(*) FROM customers
UNION ALL SELECT 'products', COUNT(*) FROM products;

-- Checking for null values in the sales table
SELECT
	COUNT(*) - COUNT(sale_id) AS null_sale_id,
	COUNT(*) - COUNT(order_date) AS null_date,
	COUNT(*) - COUNT(customer_id) AS null_customer_id,
	COUNT(*) - COUNT(product_id) AS null_product_id,
	COUNT(*) - COUNT(quantity) AS null_quantity,
	COUNT(*) - COUNT(unit_price) AS null_price,
	COUNT(*) - COUNT(discount_pct) AS null_discount,
	COUNT(*) - COUNT(shipping_fee) AS null_shipping,
	COUNT(*) - COUNT(payment_method) AS null_payment,
	COUNT(*) - COUNT(sales_channel) AS null_channel,
	COUNT(*) - COUNT(order_status) AS null_status,
	COUNT(*) - COUNT(gross_revenue) AS null_gross_revenue,
	COUNT(*) - COUNT(net_revenue) AS null_net_revenue,
	COUNT(*) - COUNT(region) AS null_region
FROM sales;

-- Checking for null values in the customers table
SELECT
	COUNT(*) - COUNT(customer_id) AS null_id,
	COUNT(*) - COUNT(first_name) AS null_f_name,
	COUNT(*) - COUNT(last_name) AS null_l_name,
	COUNT(*) - COUNT(email) AS null_email,
	COUNT(*) - COUNT(city) AS null_city,
	COUNT(*) - COUNT(state) AS null_state,
	COUNT(*) - COUNT(signup_date) AS null_signup,
	COUNT(*) - COUNT(customer_segment) AS null_segment,
	COUNT(*) - COUNT(acquisition_channel) AS null_channel,
	COUNT(*) - COUNT(loyalty_tier) AS null_tier,
	COUNT(*) - COUNT(marketing_opt_in) AS null_marketing
FROM customers;

-- Checking for null values in the products table
SELECT
	COUNT(*) - COUNT(product_id) AS null_id,
	COUNT(*) - COUNT(product_name) AS null_name,
	COUNT(*) - COUNT(category) AS null_category,
	COUNT(*) - COUNT(brand) AS null_brand,
	COUNT(*) - COUNT(unit_cost) AS null_cost,
	COUNT(*) - COUNT(unit_price) AS null_price,
	COUNT(*) - COUNT(supplier_region) AS null_region,
	COUNT(*) - COUNT(product_status) AS null_status,
	COUNT(*) - COUNT(launch_date) AS null_date
FROM products;

-- Checking to see if the same transaction was recorded more than once
SELECT order_date, customer_id, product_id, COUNT(*) AS times_seen
FROM sales
GROUP BY order_date, customer_id, product_id
HAVING COUNT(*) > 1
ORDER BY times_seen DESC;

-- Checking for orphan customer ids in sales
-- found 12
SELECT *
FROM sales s
LEFT JOIN customers c
	ON s.customer_id = c.customer_id
WHERE c.customer_id IS NULL
ORDER BY s.customer_id;

-- Checking the orphan customer ids against the rest
-- The oprhan ids start with '900' instead of '10'
-- Guest checkouts
SELECT customer_id
FROM sales
ORDER BY customer_id DESC;

-- Checking for orphan product ids in the sales table
-- Found 9
SELECT *
FROM sales s
LEFT JOIN products p
	ON s.product_id = p.product_id
WHERE p.product_id IS NULL
ORDER BY s.product_id;

-- Checking the orphan product ids against the res
-- The orphan ids start with '800' instead of '20'
SELECT *
FROM sales
ORDER BY product_id DESC;

-- Checking quantity, unit price, discount percentage and shipping fee for potential issues
-- No issues found with data
SELECT
	MAX(quantity) AS biggest_order,
	MIN(quantity) AS smallest_order,
	MAX(unit_price) AS most_expensive,
	MIN(unit_price) AS least_expensive,
	MAX(discount_pct) AS largest_discount,
	MIN(discount_pct) AS smallest_discount,
	MAX(shipping_fee) AS largest_fee,
	MIN(shipping_fee) AS smallest_fee
FROM sales;

-- Checking gross_revenue and net_revenue for negatives or numbers that are too large
SELECT
	MAX(gross_revenue) AS max_gross_revenue,
	MIN(gross_revenue) AS min_gross_revenue,
	MAX(net_revenue) AS max_net_revenue,
	MIN(net_revenue) AS min_net_revenue
FROM sales;

-- Checking to make sure gross_revenue is correct in every row
SELECT *
FROM sales
WHERE gross_revenue != (unit_price * quantity);

-- Checking to make sure net revenue is correct
SELECT sale_id, gross_revenue, discount_pct, net_revenue,
       ROUND(gross_revenue * (1 - discount_pct), 2) AS expected_net
FROM sales
WHERE net_revenue != ROUND(gross_revenue * (1 - discount_pct), 2);

-- Checking to see if the net revenue falls within 0.01 ABS(difference)
-- If it does than the value is okay to use
SELECT sale_id, gross_revenue, discount_pct, net_revenue,
       gross_revenue * (1 - discount_pct) AS expected_net
FROM sales
WHERE ABS(net_revenue - gross_revenue * (1 - discount_pct)) > 0.01;

-- Checking for potential blank values in first and last name
SELECT *
FROM customers
WHERE first_name LIKE '' OR first_name LIKE ' %' OR last_name LIKE '' OR last_name LIKE ' %';

-- Checking lengths in first and last name for any potential errors
SELECT
	MAX(LENGTH(first_name)) AS max_first_name,
	MIN(LENGTH(first_name)) AS min_first_name,
	MAX(LENGTH(last_name)) AS max_last_name,
	MIN(LENGTH(last_name)) AS min_last_name
FROM customers;

-- Checking email for any values that could be wrong
SELECT *
FROM customers
WHERE email LIKE ' %';

-- Checking for max and min email lengths
SELECT
	MAX(LENGTH(email)),
	MIN(LENGTH(email))
FROM customers;

-- Checking city for duplicates and potential errors
-- 43 Different citites
SELECT DISTINCT city
FROM customers
ORDER BY city;

-- Checking state for duplicates and potential erros
-- 15 different states
SELECT DISTINCT state
FROM customers
ORDER BY state;

-- Checking signup date for incorrect dates
SELECT
	MIN(signup_date),
	MAX(signup_date)
FROM customers;

-- Checking acquistion channel for incorrect values
SELECT DISTINCT acquisition_channel
FROM customers
ORDER BY acquisition_channel;

-- Checking loyalty tier for any errors
SELECT DISTINCT loyalty_tier
FROM customers
ORDER BY loyalty_tier;

-- Checking for duplicates, there should be 120 unique names
SELECT DISTINCT product_name
FROM products
ORDER BY product_name;

-- Checking category for potential errors
SELECT DISTINCT category
FROM products
ORDER BY category;

-- Checking supplier region for potential errors
SELECT DISTINCT supplier_region
FROM products
ORDER BY supplier_region;

-- Checking product status for potential errors
SELECT DISTINCT product_status
FROM products
ORDER BY product_status;

-- Checking launch date range
SELECT
	MIN(launch_date),
	MAX(launch_date)
FROM products;

-- Checking unit cost and unit price range for any potential negatives and numbers that might be too high
SELECT
	MIN(unit_cost) AS min_cost,
	MAX(unit_cost) AS max_cost,
	MIN(unit_price) AS min_price,
	MAX(unit_price) AS max_price
FROM products;

-- Checking to make sure unit price is correct in the sales table by joinig the products table
SELECT *
FROM sales s
LEFT JOIN products p
	ON s.product_id = p.product_id
WHERE s.unit_price != p.unit_price;