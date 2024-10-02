CREATE DEFINER=`root`@`localhost` PROCEDURE `get_top_n_customers_by_net_sales`(
	in_market VARCHAR(45),
    in_fiscal_year INT,
    in_top_n INT
)
BEGIN
	SELECT 
		customer,
		ROUND(SUM(net_sales)/1000000,2) as net_sales_mln
	FROM net_sales s
	JOIN dim_customer c
	ON  s.customer_code = c.customer_code
	WHERE s.fiscal_year = in_fiscal_year AND s.market = in_market 
	GROUP BY customer
	ORDER BY net_sales_mln DESC
	LIMIT in_top_n;
END