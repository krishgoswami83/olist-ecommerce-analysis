SELECT 
    c.customer_state,
    ROUND(AVG(
        EXTRACT(DAY FROM (
            o.order_delivered_customer_date - o.order_purchase_timestamp
        ))
    )::numeric, 1) AS avg_delivery_days,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
AND o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY avg_delivery_days DESC;