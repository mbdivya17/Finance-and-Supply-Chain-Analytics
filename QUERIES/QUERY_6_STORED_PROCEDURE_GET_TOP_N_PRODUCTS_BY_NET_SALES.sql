CREATE DEFINER=`root`@`localhost` PROCEDURE `get_top_n_products_by_net_sales`(
      in_fiscal_year INT,
      in_top_n INT
)
BEGIN
	SELECT 
		product,
		ROUND(SUM(net_sales)/1000000,2) as net_sales_mln
	FROM net_sales 
	WHERE fiscal_year = in_fiscal_year
	GROUP BY product
	ORDER BY net_sales_mln DESC
	LIMIT in_top_n;
END