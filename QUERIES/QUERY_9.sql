-- 9. Generate a report for top 2 markets in every region by their gross sales amount for fiscal year - 2021.

WITH cte1 AS(
			SELECT  
				 c.market,
				 c.region,
				 ROUND(SUM(gross_price_total)/1000000,2) as gross_sales_mln
			FROM gross_sales g
			JOIN dim_customer c
			   on g.customer_code = c.customer_code
			WHERE fiscal_year = 2021
			GROUP BY c.market),
	cte2 AS(
	   SELECT
	   *,
	   DENSE_RANK() OVER (PARTITION BY region ORDER BY gross_sales_mln DESC ) AS rn
       FROM cte1)
SELECT * FROM cte2 WHERE rn <= 2 ;
