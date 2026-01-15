-- TOP CATEGORIES BY RENEVUE

-- select product category name and return with revenue desc...
-- also added delivered orders and items sold, AVG item per order

SELECT pcn.product_category_name, 
		SUM(oi.price + oi.freight_value) AS revenue,
		-- This is counting unique orders that were successfully delivered		    
		COUNT(DISTINCT o.order_id) AS delivered_orders, 	
		-- This is counting individual product units sold		
		COUNT(oi.order_item_id) AS items_sold, 
		--This tells you: ~1.0 → people usually buy one item OR >1.0 → people bundle items		
		ROUND(COUNT(oi.order_item_id)::numeric / COUNT(DISTINCT o.order_id), 2) AS avg_items_per_order
		FROM products pcn
JOIN order_items oi ON oi.product_id = pcn.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_purchase_timestamp IS NOT NULL AND o.order_status = 'delivered'
GROUP BY pcn.product_category_name
ORDER BY revenue DESC;



-- SELLER CONCENTRATION

--The top 10 sellers account for 12.9% of total delivered revenue 
--The top 50 sellers account for 32.5%, indicating a highly fragmented marketplace.

--got the revenue per seller and then ranked them from top 1 to etc
WITH seller_ranked AS (
  SELECT
    s.seller_id,
    SUM(oi.price + oi.freight_value) AS seller_revenue,
    COUNT(DISTINCT o.order_id) AS delivered_orders,
    COUNT(oi.order_item_id) AS items_sold,
    ROW_NUMBER() OVER (ORDER BY SUM(oi.price + oi.freight_value) DESC) AS seller_rank
  FROM sellers s
  JOIN order_items oi ON s.seller_id = oi.seller_id
  JOIN orders o ON oi.order_id = o.order_id
  WHERE o.order_purchase_timestamp IS NOT NULL AND o.order_status = 'delivered'
  GROUP BY s.seller_id
),
-- add up seller revenue for every seller
total AS (
  SELECT SUM(seller_revenue) AS total_revenue
  FROM seller_ranked
)
-- get the percentage of top 10 seller/total revenue
-- get the percentage of top 50 sellers/total revenue
SELECT
  ROUND( 100 * (SELECT SUM(seller_revenue)
   FROM seller_ranked
   WHERE seller_rank <= 10) / total.total_revenue , 2) AS top_10_share,

  ROUND(100 * (SELECT SUM(seller_revenue)
   FROM seller_ranked
   WHERE seller_rank <= 50) / total.total_revenue , 2) AS top_50_share
FROM total;




--SELLER CONCENTRATION BY CATEGORY

--get revenue and rank by revenue desc
WITH category_rank AS (
  SELECT
    pcn.product_category_name,
    oi.seller_id,
    SUM(oi.price + oi.freight_value) AS revenue,
    ROW_NUMBER() OVER (PARTITION BY pcn.product_category_name 
	ORDER BY SUM(oi.price + oi.freight_value) DESC ) AS seller_rank
  FROM products pcn
  JOIN order_items oi ON oi.product_id = pcn.product_id
  JOIN orders o ON oi.order_id = o.order_id
  WHERE o.order_purchase_timestamp IS NOT NULL
    AND o.order_status = 'delivered'
  GROUP BY pcn.product_category_name, oi.seller_id
),

-- total revenue of top categories
category_total AS (
  SELECT
    product_category_name,
    SUM(revenue) AS category_revenue,
	COUNT(DISTINCT seller_id) AS sellers_in_category
  FROM category_rank
  GROUP BY product_category_name
)
-- top 1 seller revenue and top 5 seller revenue 
SELECT
  
  ct.product_category_name,
  ct.category_revenue,
  ct.sellers_in_category,
  ROUND(100 * (SELECT SUM(cr.revenue)
      FROM category_rank cr
      WHERE cr.product_category_name = ct.product_category_name 
	  AND cr.seller_rank <= 1) / ct.category_revenue, 2) AS top_1_seller_pct,
  ROUND(100 * (SELECT SUM(cr.revenue)
      FROM category_rank cr
      WHERE cr.product_category_name = ct.product_category_name
      AND cr.seller_rank <= 5) / ct.category_revenue, 2) AS top_5_seller_pct

FROM category_total ct
ORDER BY ct.category_revenue DESC;





