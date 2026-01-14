--BASE TO REUSE

-- number of days between purchase and delivery
-- checks for nulls in review score, timestamp, customer date
-- unique id only, no duplicates

WITH review_base AS (
SELECT DISTINCT o.order_id,
-- cannot cast interval and integer so change to integer days 
    (o.order_delivered_customer_date::date) - (o.order_purchase_timestamp::date) AS delivery_days,
     orr.review_score
FROM orders o
JOIN order_reviews orr ON o.order_id = orr.order_id
WHERE o.order_status = 'delivered'
AND o.order_purchase_timestamp IS NOT NULL
AND o.order_delivered_customer_date IS NOT NULL
AND orr.review_score IS NOT NULL

)

--AVERAGE DELIVERY TIME BY REVIEW SCORE

--we reuse deliverty_time formula from the cte
-- find the averabe by review score
-- count orders by review score
SELECT
  review_score,
  ROUND(AVG(delivery_days), 2) AS avg_delivery_days,
  COUNT(*) AS orders
FROM review_base
GROUP BY review_score
ORDER BY review_score;

