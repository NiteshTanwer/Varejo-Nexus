CREATE OR REPLACE VIEW `synthetic-arc-477810-q9.olist_data.monthly_demand_trends` AS
SELECT 
    DATE_TRUNC(o.order_purchase_timestamp, MONTH) as month,
    p.product_category_name,
    COUNT(DISTINCT o.order_id) as order_count,
    SUM(oi.price) as total_revenue,
    AVG(oi.freight_value) as avg_shipping_cost,
    AVG(DATE_DIFF(o.order_delivered_customer_date, o.order_purchase_timestamp, DAY)) as avg_delivery_days,
    COUNT(DISTINCT s.seller_id) as active_sellers
FROM `olist_data.orders` o
JOIN `olist_data.order_items` oi ON o.order_id = oi.order_id
JOIN `olist_data.sellers` s ON oi.seller_id = s.seller_id
LEFT JOIN `olist_data.products` p ON oi.product_id = p.product_id
WHERE o.order_status = 'delivered'
    AND o.order_purchase_timestamp >= '2017-01-01'
GROUP BY 1, 2;