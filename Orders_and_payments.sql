-- Fraction of orders that were cancelled
-- created cancelled order count by month of year

WITH cancelled AS (SELECT COUNT(DISTINCT order_id) AS orders_cancelled,
       DATE_TRUNC('month', order_purchase_timestamp) AS Monthbyyear 
	   FROM orders
WHERE order_status = 'canceled' 
GROUP BY Monthbyyear
),

-- created total order count by month of year
total_orders AS (SELECT COUNT(DISTINCT order_id) AS totalorders,
       DATE_TRUNC('month', order_purchase_timestamp) AS Monthbyyear 
	   FROM orders 
GROUP BY Monthbyyear
)

-- to get the fraction, I divided cancelled/ total order 
-- cast into float and turn nulls into zero
--  left join to keep every month from total orders, even if no cancellations
SELECT t.Monthbyyear,
	   COALESCE(c.orders_cancelled, 0)::FLOAT / t.totalorders  AS fraction_cancelled
FROM total_orders t
LEFT JOIN cancelled c ON c.Monthbyyear = t.Monthbyyear
ORDER BY t.Monthbyyear;

-------------------------------------------------------------------------------

-- Group payments into installment buckets 
-- Groups (1, 2-6, 7+)
-- count how many payments fall into each bucket

WITH count_payments  AS (SELECT order_id, 
CASE
  WHEN payment_installments = 1 THEN '1'
  WHEN payment_installments BETWEEN 2 AND 6 THEN '2–6'
  ELSE '7+'
END AS buckets
FROM order_payments)

SELECT buckets, COUNT(order_id) AS count_inst FROM count_payments

GROUP BY buckets 
ORDER BY buckets ASC
