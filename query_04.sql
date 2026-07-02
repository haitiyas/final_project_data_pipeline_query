--Nomor 04
----------------------------------
----Most favorite channel
SELECT
    c.channel_name,
    COUNT(f.transaction_id) AS transaction_volume,
    SUM(f.amount) AS transaction_value
FROM fact_transactions f
JOIN dim_channels c
    ON f.channel_id = c.channel_id
WHERE f.status = 'SUCCESS'
GROUP BY
    c.channel_name
ORDER BY
    transaction_volume DESC;
-------------------------------------