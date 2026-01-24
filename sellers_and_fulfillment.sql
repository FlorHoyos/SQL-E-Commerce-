WITH seller_delivered AS (
  SELECT
    s.seller_id,
    s.seller_state,
    COUNT(DISTINCT CASE WHEN o.order_status = 'delivered' THEN o.order_id END) AS delivered_orders
  FROM sellers s
  LEFT JOIN order_items oi
    ON oi.seller_id = s.seller_id
  LEFT JOIN orders o
    ON o.order_id = oi.order_id
  GROUP BY s.seller_id, s.seller_state
)
SELECT
  seller_state,
  COUNT(seller_id) AS sellers_never_delivered
FROM seller_delivered
WHERE delivered_orders = 0
GROUP BY seller_state
ORDER BY sellers_never_delivered DESC;
