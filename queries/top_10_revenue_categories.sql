-- TODO: 
-- This query will return a table with the top 10 revenue categories
-- in English, the number of orders and their total revenue. 
-- It will have different columns:
--      Category, that will contain the top 10 revenue categories;
--      Num_order, with the total amount of orders of each category;
--      Revenue, with the total revenue of each category.

-- HINT: 
-- All orders should have a delivered status and the Category and actual delivery date should be not null.
-- For simplicity, if there are orders with multiple product categories, consider the full order's payment_value in the summation of revenue of each category

WITH categories AS (
    SELECT
        pc.product_category_name_english,
        p.product_id
    FROM olist_products p
    JOIN product_category_name_translation pc
        ON pc.product_category_name = p.product_category_name
),
tracker AS (
    SELECT 
        c.product_category_name_english,
        oi.order_id
    FROM categories c
    JOIN olist_order_items oi
     ON c.product_id = oi.product_id
    JOIN olist_orders o
        ON oi.order_id = o.order_id
    WHERE o.order_status = 'delivered'
      AND o.order_delivered_customer_date IS NOT NULL
)
SELECT
    t.product_category_name_english AS Category,
    COUNT(DISTINCT t.order_id) AS Num_order,
    SUM(p.payment_value)AS Revenue
FROM tracker t
JOIN olist_order_payments p
    ON p.order_id = t.order_id
GROUP BY Category
ORDER BY Revenue DESC
LIMIT 10