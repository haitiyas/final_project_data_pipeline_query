---Nomor 02
--- TOP 3 Customer
WITH customer_summary AS (
    SELECT
        c.segment,
        c.customer_id,
        c.full_name,
        COUNT(f.transaction_id) AS transaction_volume,
        SUM(f.amount) AS transaction_value,
        ROW_NUMBER() OVER (
            PARTITION BY c.segment
            ORDER BY COUNT(f.transaction_id) DESC
        ) AS rn
    FROM fact_transactions f
    JOIN dim_customers c
        ON f.customer_id = c.customer_id
    WHERE f.status = 'SUCCESS'
    GROUP BY
        c.segment,
        c.customer_id,
        c.full_name
)

SELECT *
FROM customer_summary
WHERE rn <= 3
ORDER BY segment, transaction_volume DESC;

-------------------------
---Distribusi Customer
---berdasarkan volume
SELECT
    c.segment,
    COUNT(f.transaction_id) AS transaction_volume,
    ROUND(
        COUNT(f.transaction_id) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS pct_volume
FROM fact_transactions f
JOIN dim_customers c
    ON f.customer_id = c.customer_id
WHERE f.status = 'SUCCESS'
GROUP BY c.segment
ORDER BY transaction_volume DESC;

---berdasarkan nilai transaksi
SELECT
    c.segment,
    SUM(f.amount) AS transaction_value,
    ROUND(
        SUM(f.amount) * 100.0 /
        SUM(SUM(f.amount)) OVER (),
        2
    ) AS pct_value
FROM fact_transactions f
JOIN dim_customers c
    ON f.customer_id = c.customer_id
WHERE f.status = 'SUCCESS'
GROUP BY c.segment
ORDER BY transaction_value DESC;