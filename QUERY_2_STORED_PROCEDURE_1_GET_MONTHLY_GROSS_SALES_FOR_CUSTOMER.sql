CREATE DEFINER=`root`@`localhost` PROCEDURE `get_monthly_gross_sales_for_customer`(
   c_code INT
)
BEGIN
      SELECT 
             s.date,
             SUM(ROUND(g.gross_price * s.sold_quantity)) AS monthly_sales
	  FROM fact_sales_monthly s
	  JOIN fact_gross_price g 
      ON g.product_code = s.product_code
	  AND g.fiscal_year = get_fiscal_year(s.date)
      WHERE
		  customer_code = c_code
      GROUP BY s.date
      ORDER BY s.date;
END