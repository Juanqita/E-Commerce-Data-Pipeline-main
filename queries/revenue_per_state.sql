-- TODO: 
-- This query will return a table with two columns: customer_state and Revenue. 
-- The first one will have the letters that identify the top 10 states 
-- with most revenue and the second one the total revenue of each.
SELECT
    c.customer_state,
    SUM(op.payment_value) AS Revenue
FROM
    olist_orders AS o
JOIN
    olist_customers AS c ON o.customer_id = c.customer_id
JOIN
    olist_order_payments AS op ON o.order_id = op.order_id
WHERE
    o.order_status = 'delivered'
    AND o.order_delivered_customer_date IS NOT NULL
    AND o.order_delivered_customer_date >= o.order_purchase_timestamp
GROUP BY
    c.customer_state
ORDER BY
    Revenue DESC
LIMIT 10
-- HINT: 
-- All orders should have a delivered status and the actual delivery date should be not null. 