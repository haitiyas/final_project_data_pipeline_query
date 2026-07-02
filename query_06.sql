---Nomor 6
---Transaksi besar lebih dari 100jt
SELECT
    f.transaction_id,
    c.full_name,
    a.product_name,
    f.transaction_type,
    f.amount,
    f.transaction_at
FROM fact_transactions f
JOIN dim_customers c
    ON f.customer_id = c.customer_id
JOIN dim_accounts a
    ON f.account_id = a.account_id
WHERE
    f.status = 'SUCCESS'
    AND f.amount >= 100000000
ORDER BY f.amount DESC;

---Transaksi tidak wajar
SELECT
    c.customer_id,
    c.full_name,
    f.transaction_date,
    COUNT(*) AS total_transactions,
    SUM(f.amount) AS total_value
FROM fact_transactions f
JOIN dim_customers c
    ON f.customer_id = c.customer_id
WHERE f.status = 'SUCCESS'
GROUP BY
    c.customer_id,
    c.full_name,
    f.transaction_date
HAVING COUNT(*) > 20
ORDER BY total_transactions DESC;

---Failed berulang
SELECT
    c.customer_id,
    c.full_name,
    COUNT(*) AS failed_transactions
FROM fact_transactions f
JOIN dim_customers c
    ON f.customer_id = c.customer_id
WHERE f.status = 'FAILED'
GROUP BY
    c.customer_id,
    c.full_name
HAVING COUNT(*) >= 5
ORDER BY failed_transactions DESC;

