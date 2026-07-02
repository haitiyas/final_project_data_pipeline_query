--Nomor 05
SELECT
    a.product_name,
    a.account_type,
    COUNT(f.transaction_id) AS transaction_volume,
    SUM(f.amount) AS transaction_value,
    AVG(f.balance_after) AS average_balance
FROM fact_transactions f
JOIN dim_accounts a
    ON f.account_id = a.account_id
WHERE f.status = 'SUCCESS'
GROUP BY
    a.product_name,
    a.account_type
ORDER BY
    transaction_volume DESC,
    average_balance DESC;