SELECT 
    oi.seller_id,
    s.seller_state,
    ROUND(SUM(oi.price)::numeric, 2) AS total_revenue,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    ROUND(AVG(r.review_score)::numeric, 2) AS avg_rating
FROM order_items oi
JOIN sellers s ON oi.seller_id = s.seller_id
JOIN orders o ON oi.order_id = o.order_id
JOIN reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
GROUP BY oi.seller_id, s.seller_state
HAVING COUNT(DISTINCT oi.order_id) > 50
ORDER BY total_revenue DESC
LIMIT 20;