-- ============================================================
-- Database Indexing Example
-- Demonstrates how proper indexing improves query performance
-- ============================================================

-- Sample table: a large orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_status VARCHAR(20) NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL
);

-- ============================================================
-- ❌ WITHOUT AN INDEX
-- ============================================================
-- This query scans the ENTIRE table row by row (full table scan)
-- to find matching rows — slow on large datasets.

-- EXPLAIN SELECT * FROM orders WHERE customer_id = 1023;

-- ============================================================
-- ✅ WITH AN INDEX
-- ============================================================
-- Add an index on customer_id since it's frequently used in WHERE clauses

CREATE INDEX idx_customer_id ON orders (customer_id);

-- Now the same query uses the index instead of scanning every row:
-- EXPLAIN SELECT * FROM orders WHERE customer_id = 1023;

-- ============================================================
-- Composite Index Example
-- ============================================================
-- Useful when queries commonly filter by multiple columns together

CREATE INDEX idx_status_date ON orders (order_status, order_date);

-- This speeds up queries like:
-- SELECT * FROM orders WHERE order_status = 'Shipped' AND order_date > '2025-01-01';

-- ============================================================
-- Best Practices for Indexing
-- ============================================================
-- 1. Index columns frequently used in WHERE, JOIN, and ORDER BY clauses
-- 2. Avoid over-indexing — every index adds overhead on INSERT/UPDATE/DELETE
-- 3. Use composite indexes when queries filter on multiple columns together
-- 4. Regularly review query performance with EXPLAIN / EXPLAIN ANALYZE
-- 5. Drop unused indexes to save storage and improve write performance

-- ============================================================
-- Result:
-- - Faster SELECT queries on large tables
-- - Reduced full table scans
-- - Improved performance for JOIN and WHERE operations
-- ============================================================
