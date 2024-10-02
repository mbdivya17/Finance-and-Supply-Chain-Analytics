CREATE DEFINER=`root`@`localhost` PROCEDURE `get_forecast_accuracy`(
     in_fiscal_year INT
)
BEGIN
WITH forecast_err_table AS
		(SELECT 
			    s.customer_code,
				SUM(sold_quantity) AS total_sold_qty,
				SUM((forecast_quantity - sold_quantity)) AS net_error,
				SUM((forecast_quantity - sold_quantity))*100/SUM(forecast_quantity) AS net_error_pct,
				SUM(ABS(forecast_quantity - sold_quantity)) AS abs_error,
				SUM(ABS(forecast_quantity - sold_quantity))*100/SUM(forecast_quantity) AS abs_error_pct
		FROM fact_act_est s
		WHERE s.fiscal_year = in_fiscal_year
		GROUP BY customer_code)
SELECT 
    e.*,
    c.customer,
    c.market,
    IF(abs_error_pct > 100, 0, (100-abs_error_pct)) AS forecast_accuracy
FROM forecast_err_table e
JOIN dim_customer c
USING(customer_code)
ORDER BY forecast_accuracy DESC;
END