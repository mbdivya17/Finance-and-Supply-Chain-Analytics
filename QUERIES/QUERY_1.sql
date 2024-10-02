/* 1. Generate a report of individual product sales for Croma India customer of FY-2021.

The report should have following fields
-- 1. month
-- 2. product_name
-- 3. variant
-- 4. sold quantity
-- 5. gross price per month
-- 6. gross price total
*/

SELECT 
       s.date, s.product_code,
       p.product, p.variant, s.sold_quantity,
       g.gross_price,
       ROUND(s.sold_quantity*g.gross_price,2) as total_gross_price
FROM fact_sales_monthly s
JOIN dim_product p
  ON p.product_code = s.product_code
JOIN fact_gross_price g
  ON
	g.product_code = s.product_code AND
    g.fiscal_year = get_fiscal_year(s.date)
WHERE 
   customer_code = 90002002 -- Croma
   AND get_fiscal_year(date) = 2021 
ORDER BY date;