--Nomor 03
-----------------------------
--top branch per region
WITH branch_summary AS (
    SELECT
        b.region,
        b.branch_name,
        COUNT(f.transaction_id) AS transaction_volume,
        SUM(f.amount) AS transaction_value,

        ROW_NUMBER() OVER (
            PARTITION BY b.region
            ORDER BY
                COUNT(f.transaction_id) DESC,
                SUM(f.amount) DESC
        ) AS rn
    FROM fact_transactions f
    JOIN dim_branches b
        ON f.branch_id = b.branch_id

    WHERE f.status = 'SUCCESS'

    GROUP BY
        b.region,
        b.branch_name

)
SELECT
    region,
    branch_name,
    transaction_volume,
    transaction_value
FROM branch_summary
WHERE rn = 1
ORDER BY transaction_volume DESC;

-----------------------------