--Nomor 01
----------------------------------------------------
--per hari
SELECT
    d.full_date,
    COUNT(f.transaction_id) AS transaction_volume,
    SUM(f.amount) AS transaction_value
FROM fact_transactions f
JOIN dim_dim_date d
    ON f.transaction_date = d.full_date
WHERE f.status = 'SUCCESS' AND d.month=1 AND d.year=2025
GROUP BY d.full_date
ORDER BY d.full_date;
----------------
--per minggu
SELECT
    d.year,
    d.week_of_year,
    COUNT(f.transaction_id) AS transaction_volume,
    SUM(f.amount) AS transaction_value
FROM fact_transactions f
JOIN dim_dim_date d
    ON f.transaction_date = d.full_date
WHERE f.status = 'SUCCESS' AND d.year=2025
GROUP BY
    d.year,
    d.week_of_year
ORDER BY
    d.year,
    d.week_of_year;
-------------------
--per bulan
SELECT
    d.year,
    d.month,
    d.month_name,
    COUNT(f.transaction_id) AS transaction_volume,
    SUM(f.amount) AS transaction_value
FROM fact_transactions f
JOIN dim_date d
    ON f.transaction_date = d.full_date
WHERE f.status = 'SUCCESS'
GROUP BY
    d.year,
    d.month,
    d.month_name
ORDER BY
    d.year,
    d.month;
------------------
----------------------------------------------------------

