WITH payments AS (
    SELECT
        order_id,
        MIN(payment_value) AS payment_value
    FROM olist_order_payments
    GROUP BY order_id
),
orders_clean AS (
    SELECT
        o.order_id,
        o.order_delivered_customer_date,
        p.payment_value
    FROM olist_orders  o
    JOIN payments p
        ON o.order_id = p.order_id
    WHERE o.order_status = 'delivered'
      AND o.order_delivered_customer_date IS NOT NULL
),
monthly_revenue AS (
    SELECT
        strftime('%m', order_delivered_customer_date) AS month_no,
        strftime('%Y', order_delivered_customer_date) AS year,
        CASE strftime('%m', order_delivered_customer_date)
            WHEN '01' THEN 'Jan'
            WHEN '02' THEN 'Feb'
            WHEN '03' THEN 'Mar'
            WHEN '04' THEN 'Apr'
            WHEN '05' THEN 'May'
            WHEN '06' THEN 'Jun'
            WHEN '07' THEN 'Jul'
            WHEN '08' THEN 'Aug'
            WHEN '09' THEN 'Sep'
            WHEN '10' THEN 'Oct'
            WHEN '11' THEN 'Nov'
            WHEN '12' THEN 'Dec'
        END AS month,
        SUM(payment_value) AS revenue
    FROM orders_clean
    GROUP BY 1, 2, 3
)
SELECT
    month_no,
    month,
    SUM(CASE WHEN year = '2016' THEN revenue ELSE 0 END) AS Year2016,
    SUM(CASE WHEN year = '2017' THEN revenue ELSE 0 END) AS Year2017,
    SUM(CASE WHEN year = '2018' THEN revenue ELSE 0 END) AS Year2018
FROM monthly_revenue
GROUP BY month_no, month
ORDER BY month_no