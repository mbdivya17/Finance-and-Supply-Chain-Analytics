-- 6. Genarate a report of top product net sales for a given fiscal year.

SELECT 
    product,
    ROUND(SUM(net_sales)/1000000,2) as net_sales_mln
FROM net_sales 
WHERE fiscal_year = 2021
GROUP BY product
ORDER BY net_sales_mln DESC
LIMIT 5;