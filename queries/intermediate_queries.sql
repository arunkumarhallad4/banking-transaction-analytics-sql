-- =============================================
-- INTERMEDIATE QUERIES
-- =============================================

-- 1. Total spend per customer (Debit transactions)
SELECT c.customer_id, c.name, c.city,
       COUNT(t.txn_id) AS total_txns,
       ROUND(SUM(t.amount), 2) AS total_spend
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_id = t.account_id
WHERE t.txn_type = 'Debit'
GROUP BY c.customer_id, c.name, c.city
ORDER BY total_spend DESC;

-- 2. Top 10 highest spending customers
SELECT c.name, c.city, ROUND(SUM(t.amount), 2) AS total_spend
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_id = t.account_id
WHERE t.txn_type = 'Debit' AND t.status = 'Success'
GROUP BY c.customer_id, c.name, c.city
ORDER BY total_spend DESC
LIMIT 10;

-- 3. Monthly transaction volume trend
SELECT DATE_FORMAT(txn_date, '%Y-%m') AS month,
       COUNT(*) AS txn_count,
       ROUND(SUM(amount), 2) AS total_amount
FROM transactions
GROUP BY month
ORDER BY month;

-- 4. Transaction volume by city
SELECT c.city,
       COUNT(t.txn_id) AS total_txns,
       ROUND(SUM(t.amount), 2) AS total_volume
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_id = t.account_id
GROUP BY c.city
ORDER BY total_volume DESC;

-- 5. Accounts with failed transactions
SELECT a.account_id, c.name,
       COUNT(*) AS failed_count
FROM transactions t
JOIN accounts a ON t.account_id = a.account_id
JOIN customers c ON a.customer_id = c.customer_id
WHERE t.status = 'Failed'
GROUP BY a.account_id, c.name
ORDER BY failed_count DESC;

-- 6. Average transaction amount by payment channel
SELECT category,
       ROUND(AVG(amount), 2) AS avg_amount,
       COUNT(*) AS total_txns
FROM transactions
GROUP BY category
ORDER BY avg_amount DESC;
