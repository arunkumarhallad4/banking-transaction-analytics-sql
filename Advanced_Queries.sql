-- =============================================
-- ADVANCED QUERIES (Window Functions & CTEs)
-- =============================================

-- 1. Rank customers by spending within each city
SELECT c.name, c.city,
       ROUND(SUM(t.amount), 2) AS total_spend,
       RANK() OVER (PARTITION BY c.city ORDER BY SUM(t.amount) DESC) AS city_rank
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_id = t.account_id
WHERE t.txn_type = 'Debit'
GROUP BY c.customer_id, c.name, c.city;

-- 2. Month-over-month transaction growth using LAG
WITH monthly AS (
    SELECT DATE_FORMAT(txn_date, '%Y-%m') AS month,
           ROUND(SUM(amount), 2) AS total
    FROM transactions
    GROUP BY month
)
SELECT month,
       total,
       LAG(total) OVER (ORDER BY month) AS prev_month,
       ROUND(
           (total - LAG(total) OVER (ORDER BY month)) /
           LAG(total) OVER (ORDER BY month) * 100, 2
       ) AS growth_pct
FROM monthly;

-- 3. Running total of transactions per account
SELECT txn_id, account_id, txn_date, amount,
       ROUND(SUM(amount) OVER (PARTITION BY account_id ORDER BY txn_date), 2) AS running_total
FROM transactions
ORDER BY account_id, txn_date;

-- 4. Fraud detection: Flagged accounts with high amounts
SELECT a.account_id, c.name, c.city,
       COUNT(*) AS flagged_count,
       ROUND(SUM(t.amount), 2) AS flagged_amount
FROM transactions t
JOIN accounts a ON t.account_id = a.account_id
JOIN customers c ON a.customer_id = c.customer_id
WHERE t.status = 'Flagged'
GROUP BY a.account_id, c.name, c.city
HAVING flagged_count >= 2
ORDER BY flagged_amount DESC;

-- 5. Top payment channel per city using RANK
WITH channel_city AS (
    SELECT c.city, t.category,
           COUNT(*) AS usage_count,
           RANK() OVER (PARTITION BY c.city ORDER BY COUNT(*) DESC) AS rnk
    FROM transactions t
    JOIN accounts a ON t.account_id = a.account_id
    JOIN customers c ON a.customer_id = c.customer_id
    GROUP BY c.city, t.category
)
SELECT city, category AS top_channel, usage_count
FROM channel_city
WHERE rnk = 1;

-- 6. Customers with above-average account balance
SELECT c.name, c.city, c.account_type,
       ROUND(a.balance, 2) AS balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
WHERE a.balance > (SELECT AVG(balance) FROM accounts)
ORDER BY balance DESC;
