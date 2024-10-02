-- 7. Genarate a bar chart report for financial year - 2021 for top 10 customers by % net sales.

WITH cte1 as
(SELECT 
		customer,
		ROUND(SUM(net_sales)/1000000,2) as net_sales_mln
FROM net_sales s
JOIN dim_customer c
  ON  s.customer_code = c.customer_code
WHERE s.fiscal_year = 2021 
GROUP BY customer)
SELECT 
    *,
    net_sales_mln*100/SUM(net_sales_mln) OVER() AS pct_share_overall
    FROM cte1
ORDER BY net_sales_mln DESC;