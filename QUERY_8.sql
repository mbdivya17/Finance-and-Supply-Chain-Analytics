-- 8. Generate a report for financial year - 2021 for top 10 customers by region wise % net sales

WITH cte1 as
(SELECT 
        c.customer,
		c.region,
		ROUND(SUM(net_sales)/1000000,2) as net_sales_mln
FROM net_sales s
JOIN dim_customer c
  ON  s.customer_code = c.customer_code
WHERE s.fiscal_year = 2021 
GROUP BY c.customer,c.region)
SELECT 
    *,
    net_sales_mln*100/SUM(net_sales_mln) OVER(PARTITION BY region) AS pct_share_region
FROM cte1
ORDER BY region,net_sales_mln DESC;