CREATE TABLE kimia_farma.Analysis_table AS
SELECT
    ft.transaction_id,
    ft.date,
    kc.branch_id,
    REPLACE(kc.branch_name, 'Kimia Farma - ', '') AS branch_name,
    kc.kota AS city,
    kc.provinsi AS province,
    kc.rating AS branch_rate,
    ft.customer_name,
    p.product_id,
    p.product_name,
    ft.price AS actual_price,
    ft.discount_percentage,
    CASE
        WHEN ft.price <= 50000 THEN 0.10
        WHEN ft.price > 50000 AND ft.price <= 100000 THEN 0.15
        WHEN ft.price > 100000 AND ft.price <= 300000 THEN 0.20
        WHEN ft.price > 300000 AND ft.price <= 500000 THEN 0.25
        WHEN ft.price > 500000 THEN 0.30
    END AS persentase_gross_laba,
    ft.price * (1 - ft.discount_percentage) AS nett_sales,
    (ft.price * (1 - ft.discount_percentage) * 
        CASE
            WHEN ft.price <= 50000 THEN 0.1
            WHEN ft.price > 50000 - 100000 THEN 0.15
            WHEN ft.price > 100000 - 300000 THEN 0.2
            WHEN ft.price > 300000 - 500000 THEN 0.25
            WHEN ft.price > 500000 THEN 0.30
            ELSE 0.3
        END) AS nett_profit,
    ft.rating AS transaction_rate,
FROM
    kimia_farma.kf_final_transaction AS ft
LEFT JOIN 
    kimia_farma.kf_kantor_cabang AS kc
    ON ft.branch_id = kc.branch_id
LEFT JOIN 
    kimia_farma.kf_product AS p
    ON ft.product_id = p.product_id;
