-- What is the total gross revenue?
SELECT
	SUM(gross_revenue) AS total_gross_revenue
FROM sales;

-- What is the total net revenue?
SELECT
	SUM(net_revenue) AS total_net_revenue
FROM sales;

-- How many sales? How many returned? Percentage Returned?
SELECT COUNT(*) AS total_orders,
       SUM(CASE WHEN order_status = 'Returned' THEN 1 ELSE 0 END) AS total_returns,
       ROUND(100.0 * SUM(CASE WHEN order_status = 'Returned' THEN 1 ELSE 0 END) / COUNT(*), 2) AS pct_returned
FROM sales;

--
SELECT 
	SUM(net_revenue) AS net_revenue_after_returns
FROM sales
WHERE order_status != 'Returned';

-- Average revenue per sale?
SELECT ROUND(AVG(net_revenue), 2) AS avg_net_revenue
FROM sales;

-- Checking total revenue by month
SELECT DATE_TRUNC('month', order_date)::date AS month,
       SUM(net_revenue) AS total_net_revenue
FROM sales
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

SELECT *
FROM sales
LIMIT 10;