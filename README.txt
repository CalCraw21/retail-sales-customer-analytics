Retail Sales & Customer Analytics — Synthetic Portfolio Dataset

Files
- sales.csv: 5,000 transaction-line records. Primary key: sale_id. Foreign keys: customer_id -> customers.customer_id; product_id -> products.product_id.
- customers.csv: 800 customer records. Primary key: customer_id.
- products.csv: 120 product records. Primary key: product_id.

Date range: 2023-01-01 through 2025-12-31 (synthetic).
Data-quality scenarios intentionally included:
- 12 sales rows have customer_id values that do not exist in customers.csv.
- 9 sales rows have product_id values that do not exist in products.csv.
- At least 20 customers have no matching sales rows.
- Category, channel, payment, status, region, quantity, and discount distributions are deliberately uneven.

Suggested analysis questions
1. How has monthly net revenue changed over time?
2. Which product categories and brands generate the most revenue?
3. What are average order-line values by sales channel and payment method?
4. How do customer segments and loyalty tiers differ in purchasing activity?
5. What is the return/cancellation rate by category, region, and channel?
6. How many unmatched customer and product references exist, and how would you handle them in a data pipeline?

Notes
- All IDs are numeric-only.
- Names and emails are synthetic; email addresses use example.com.
- Revenue values are synthetic and are not intended to represent any real company.
