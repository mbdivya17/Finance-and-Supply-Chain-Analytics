/* 2 Generate an aggregate monthly gross sales report for Croma India customers.

The report should have the following fields.
1. month
2. total gross sales amount to croma india in this month.*/

SELECT 
        s.date, 
        SUM(ROUND(g.gross_price*s.sold_quantity,2)) as gross_price_total
FROM fact_sales_monthly s 
JOIN fact_gross_price g
 ON 
    g.product_code = s.product_code AND
    g.fiscal_year = get_fiscal_year(s.date)
WHERE 
    customer_code = 90002002 -- Croma 
GROUP BY s.date 
ORDER BY s.date;