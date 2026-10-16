CREATE TABLE customers (
    customer_id BIGINT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(150),
    city VARCHAR(100),
    state VARCHAR(2),
    signup_date DATE,
    customer_segment VARCHAR(50),
    acquisition_channel VARCHAR(50),
    loyalty_tier VARCHAR(20),
    marketing_opt_in BOOLEAN
);

CREATE TABLE products (
    product_id BIGINT PRIMARY KEY,
    product_name VARCHAR(150),
    category VARCHAR(50),
    brand VARCHAR(100),
    unit_cost NUMERIC(10, 2),
    unit_price NUMERIC(10, 2),
    supplier_region VARCHAR(30),
    product_status VARCHAR(30),
    launch_date DATE
);

CREATE TABLE sales (
    sale_id BIGINT PRIMARY KEY,
    order_date DATE,
    customer_id BIGINT,
    product_id BIGINT,
    quantity INTEGER,
    unit_price NUMERIC(10, 2),
    discount_pct NUMERIC(4, 2),
    shipping_fee NUMERIC(10, 2),
    payment_method VARCHAR(50),
    sales_channel VARCHAR(50),
    order_status VARCHAR(30),
    gross_revenue NUMERIC(12, 2),
    net_revenue NUMERIC(12, 2),
    region VARCHAR(30)
);
