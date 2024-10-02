-- 4. Generate report for top market net sales for a given fiscal year.

select * from net_sales;
SELECT 
    market,
    ROUND(SUM(net_sales)/1000000,2) as net_sales_mln
FROM net_sales 
WHERE fiscal_year = 2021
GROUP BY market
ORDER BY net_sales_mln DESC
LIMIT 5;