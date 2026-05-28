-- =============================================
-- BASIC QUERIES
-- =============================================

-- 1. Total number of transactions
SELECT COUNT(*) AS total_transactions FROM transactions;

-- 2. Total transaction amount
SELECT ROUND(SUM(amount), 2) AS total_volume FROM transactions;

-- 3. Count of transactions by status
SELECT status, COUNT(*) AS count
FROM transactions
GROUP BY status;

-- 4. Count of transactions by type (Debit/Credit)
SELECT txn_type, COUNT(*) AS count, ROUND(SUM(amount), 2) AS total_amount
FROM transactions
GROUP BY txn_type;

-- 5. Most used payment channel
SELECT category, COUNT(*) AS usage_count
FROM transactions
GROUP BY category
ORDER BY usage_count DESC;

-- 6. All customers from Bangalore
SELECT * FROM customers WHERE city = 'Bangalore';

-- 7. Transactions above ₹1,00,000
SELECT * FROM transactions WHERE amount > 100000
ORDER BY amount DESC;

-- 8. Number of customers by account type
SELECT account_type, COUNT(*) AS total
FROM customers
GROUP BY account_type;
