SELECT
-- truncate to start of month and return 'year-month-01'
  DATE_TRUNC('month', a.order_purchase_timestamp) AS Monthbyyear, 
-- count how many unique orders exist
  COUNT(DISTINCT a.order_id) AS order_count,
-- adds item price + freight value, then sums everything within each group
  SUM(b.price + b.freight_value) AS revenue
-- starts with the orders table and rename a
FROM orders a
-- joins orders table to order_items(renamed b) table by order_id 
JOIN order_items b ON a.order_id = b.order_id
-- filter orders with no time stamp, takes it out
WHERE order_purchase_timestamp IS NOT NULL
-- groups by month of the year
GROUP BY MonthByYear
-- orders by month of year asc
ORDER BY MonthByYear;