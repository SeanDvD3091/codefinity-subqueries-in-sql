--SELECT p.category, SUM(o.quantity) AS total_quantity FROM products p,orders o WHERE p.product_id = o.product_id AND p.product_id IN(SELECT MAX(quantity) FROM orders) GROUP BY p.category;

SELECT 
  p.category, 
  SUM(o.quantity) AS total_quantity
FROM orders o
JOIN products p 
  ON o.product_id = p.product_id
GROUP BY p.category
HAVING SUM(o.quantity) = (
  SELECT 
  MAX(category_total) 
FROM (
  SELECT 
    SUM(o2.quantity) AS category_total
  FROM orders o2
  JOIN products p2 
    ON o2.product_id = p2.product_id
  GROUP BY p2.category
) AS totals
);