-- create a formula that calculates delivered orders per seller
-- left join to keep sellers even if they have no order items
-- join only delivered orders only


WITH seller_delivered AS (
  SELECT
    s.seller_id,
    s.seller_state,
    COUNT(DISTINCT o.order_id) AS delivered_orders
  FROM sellers s
  LEFT JOIN order_items oi ON oi.seller_id = s.seller_id
  LEFT JOIN orders o ON o.order_id = oi.order_id AND o.order_status = 'delivered'
  GROUP BY s.seller_id, s.seller_state
)

-- output states with 0 deliveries and count how many
SELECT
  seller_state,
  COUNT(seller_id) AS sellers_never_delivered
FROM seller_delivered
WHERE delivered_orders = 0
GROUP BY seller_state
ORDER BY sellers_never_delivered DESC;
