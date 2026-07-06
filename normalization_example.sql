-- ============================================================
-- Database Normalization Example
-- Demonstrates converting an unnormalized table into 3NF
-- ============================================================

-- ❌ BEFORE: Unnormalized table (redundant data, mixed concerns)
-- Problem: Customer info is repeated for every order, and
-- product info is repeated for every line item.

CREATE TABLE orders_unnormalized (
    order_id INT,
    customer_name VARCHAR(100),
    customer_email VARCHAR(100),
    customer_address VARCHAR(255),
    product_name VARCHAR(100),
    product_price DECIMAL(10,2),
    quantity INT,
    order_date DATE
);

-- ============================================================
-- ✅ AFTER: Normalized into 3NF (separate, related tables)
-- ============================================================

-- 1. Customers table (1NF/2NF: atomic values, no repeating groups)
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100) UNIQUE NOT NULL,
    customer_address VARCHAR(255)
);

-- 2. Products table (removes repeating product info)
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    product_price DECIMAL(10,2) NOT NULL
);

-- 3. Orders table (references customers, no redundant customer data)
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 4. Order_Items table (many-to-many between orders and products)
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- ============================================================
-- Result:
-- - No duplicate customer/product data across rows
-- - Easier updates (change a product price in ONE place)
-- - Better data integrity via foreign key constraints
-- - Reduced storage and improved query performance
-- ============================================================
