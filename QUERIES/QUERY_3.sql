/*
3. Generate a yearly gross sales report for Croma India Customers.

The report should have the following fields.

1. Fiscal Year
2. Total Gross Sales amount In that year from Croma */

SELECT 
        g.fiscal_year as fiscal_year,
        SUM(ROUND(s.sold_quantity*g.gross_price,2)) as yearly_sales
FROM fact_sales_monthly s 
JOIN fact_gross_price g
ON 
   g.product_code = s.product_code AND
   g.fiscal_year = get_fiscal_year(s.date)
WHERE customer_code = 90002002 -- Croma 
GROUP BY 1
ORDER BY 1;