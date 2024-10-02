CREATE DEFINER=`root`@`localhost` PROCEDURE `get_monthly_gross_sales_for_customers`(
   in_customer_codes TEXT
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
		  FIND_IN_SET(s.customer_code, in_customer_codes)>0
      GROUP BY s.date
      ORDER BY s.date;
END