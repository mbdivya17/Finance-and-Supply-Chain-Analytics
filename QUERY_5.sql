-- 5. Genarate a report of top customers net sales for a given fiscal year.

SELECT 
    c.customer,
    ROUND(SUM(net_sales)/1000000,2) as net_sales_mln
FROM net_sales n
JOIN dim_customer c
ON  n.customer_code = c.customer_code
WHERE fiscal_year = 2021
GROUP BY c.customer
ORDER BY net_sales_mln DESC
LIMIT 5;