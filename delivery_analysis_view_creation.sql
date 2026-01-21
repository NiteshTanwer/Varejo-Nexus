CREATE VIEW `synthetic-arc-477810-q9.olist_data.delivery_analysis` as
SELECT 
    o.order_id,
    o.customer_id,
    oi.seller_id,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    oi.price,
    oi.freight_value,
    -- Difference in days: (end, start, unit)
    DATE_DIFF(o.order_delivered_customer_date, o.order_purchase_timestamp, DAY) as total_delivery_days,
    DATE_DIFF(o.order_delivered_customer_date, o.order_estimated_delivery_date, DAY) as days_early_late,
    CASE 
        WHEN o.order_delivered_customer_date <= o.order_estimated_delivery_date THEN 'On Time'
        ELSE 'Late'
    END as delivery_status,
    s.seller_state,
    c.customer_state,
    p.product_category_name
FROM `olist_data.orders` o
JOIN `olist_data.order_items` oi ON o.order_id = oi.order_id
JOIN `olist_data.sellers` s ON oi.seller_id = s.seller_id
JOIN `olist_data.customers` c ON o.customer_id = c.customer_id
LEFT JOIN `olist_data.products` p ON oi.product_id = p.product_id
WHERE o.order_status = 'delivered'
    AND o.order_delivered_customer_date IS NOT NULL;