SELECT
    product_id,
    sale_date,
    sale_amount,
    AVG(sale_amount) OVER (
        PARTITION BY product_id
        ORDER BY sale_date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS moving_avg_7_days,
    (sale_amount -
        LAG(sale_amount) OVER (PARTITION BY product_id ORDER BY sale_date)
     ) / LAG(sale_amount) OVER (PARTITION BY product_id ORDER BY sale_date)
     * 100 AS pct_change
FROM sales
ORDER BY product_id, sale_date;

