SELECT COUNT(p.product_id), p.product_category_name, pt.product_category_name_english
FROM products p

LEFT JOIN product_category_name_translation pt ON p.product_category_name = pt.product_category_name
WHERE pt.product_category_name IS NULL 
GROUP BY p.product_category_name, pt.product_category_name_english 