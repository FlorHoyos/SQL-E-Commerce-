-- REVENUE BY STATE

SELECT
-- select customer state from c table
  c.customer_state,
-- price+freight value then sum all together from table oi and rename revenue
  SUM(oi.price + oi.freight_value) AS revenue
-- start with table customers and rename c 
FROM customers c
-- join from table orders(rename o) connect it with customer id
JOIN orders o ON o.customer_id = c.customer_id
-- join from table order_item(rename oi) connect it with order id
JOIN order_items oi ON oi.order_id = o.order_id
-- where revevue reflects delivered only AND not null
WHERE o.order_status = 'delivered' AND o.order_purchase_timestamp IS NOT NULL
--group by state
GROUP BY c.customer_state
--order by revenue from big to small
ORDER BY revenue DESC;


--Monthly new vs repeat customers

--first purchase

WITH first_purchase AS (
  SELECT
    c.customer_unique_id,
    DATE_TRUNC('month', MIN(o.order_purchase_timestamp)) AS first_purchase_month
  FROM orders o
  JOIN customers c ON c.customer_id = o.customer_id
  WHERE o.order_purchase_timestamp IS NOT NULL AND o.order_status = 'delivered'
  GROUP BY c.customer_unique_id
),
monthly_customers AS (
  SELECT DISTINCT
    DATE_TRUNC('month', o.order_purchase_timestamp) AS monthbyyear,
    c.customer_unique_id
  FROM orders o
  JOIN customers c ON c.customer_id = o.customer_id
  WHERE o.order_purchase_timestamp IS NOT NULL AND o.order_status = 'delivered'
),

----Customers whose first ever purchase happened in this month
new_customers AS (
  SELECT
    mc.monthbyyear,
    COUNT(DISTINCT mc.customer_unique_id) AS new_customers
  FROM monthly_customers mc
  JOIN first_purchase fp ON fp.customer_unique_id = mc.customer_unique_id
  WHERE mc.monthbyyear = fp.first_purchase_month
  GROUP BY monthbyyear
),
--Customers who already purchased before and came back again this month
repeat_customers AS (
  SELECT
    mc.monthbyyear,
    COUNT(DISTINCT mc.customer_unique_id) AS repeat_customers
  FROM monthly_customers mc
  JOIN first_purchase fp ON fp.customer_unique_id = mc.customer_unique_id
  WHERE mc.monthbyyear > fp.first_purchase_month
  GROUP BY monthbyyear
)
SELECT m.monthbyyear, n.new_customers, r.repeat_customers
FROM (SELECT DISTINCT monthbyyear FROM monthly_customers) m
LEFT JOIN new_customers n ON n.monthbyyear = m.monthbyyear
LEFT JOIN repeat_customers r ON r.monthbyyear = m.monthbyyear
ORDER BY monthbyyear;
