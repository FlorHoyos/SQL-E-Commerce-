-- For each state with at least 200 delivered orders
-- What is the total revenue
-- Number of delivered orders
-- Average delivery time in days

SELECT
  c.customer_state,
  SUM(oi.price + oi.freight_value) AS total_revenue,
  COUNT(DISTINCT o.order_id) AS orders_delivered,
  ROUND(AVG(o.order_delivered_customer_date::date - o.order_purchase_timestamp::date), 0) AS average_delivery_time_days
  FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
AND o.order_purchase_timestamp IS NOT NULL
AND o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
HAVING COUNT(DISTINCT o.order_id) >= 200
ORDER BY orders_delivered ASC;
