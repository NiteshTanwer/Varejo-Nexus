CREATE OR REPLACE VIEW `synthetic-arc-477810-q9.olist_data.seller_performance_dashboard` AS
SELECT 
    s.seller_id,
    s.seller_state,
    s.seller_city,
    COUNT(DISTINCT o.order_id) as total_orders,
    COUNT(DISTINCT oi.product_id) as unique_products,
    SUM(oi.price) as total_revenue,
    ROUND(AVG(oi.price), 2) as avg_order_value,
    ROUND(AVG(oi.freight_value), 2) as avg_shipping_cost,
    ROUND(AVG(DATE_DIFF(o.order_delivered_customer_date, o.order_purchase_timestamp, DAY)), 2) as avg_delivery_time,
    ROUND(AVG(r.review_score), 2) as avg_review_score,
    -- SAFE_DIVIDE ensures we don't crash on zero orders
    ROUND(SAFE_DIVIDE(
        SUM(CASE WHEN o.order_delivered_customer_date <= o.order_estimated_delivery_date THEN 1 ELSE 0 END) * 100.0, 
        COUNT(*)
    ), 2) as on_time_percentage
FROM `olist_data.sellers` s
JOIN `olist_data.order_items` oi ON s.seller_id = oi.seller_id
JOIN `olist_data.orders` o ON oi.order_id = o.order_id
LEFT JOIN `olist_data.order_reviews` r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
GROUP BY 1, 2, 3
HAVING total_orders >= 5;