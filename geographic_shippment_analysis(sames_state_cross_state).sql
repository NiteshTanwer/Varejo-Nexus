-- Analyze delivery times between seller and customer states
WITH delivery_analysis AS (
    SELECT 
        s.seller_state,
        c.customer_state,
        COUNT(*) as shipment_count,
        -- BigQuery uses DATE_DIFF(end, start, unit)
        ROUND(AVG(DATE_DIFF(o.order_delivered_customer_date, o.order_purchase_timestamp, DAY)), 2) as avg_delivery_days,
        ROUND(AVG(oi.price), 2) as avg_item_price,
        ROUND(AVG(oi.freight_value), 2) as avg_shipping_cost,
        SUM(CASE WHEN o.order_delivered_customer_date <= o.order_estimated_delivery_date 
                THEN 1 ELSE 0 END) as on_time_deliveries
    FROM `olist_data.orders` o
    JOIN `olist_data.order_items` oi ON o.order_id = oi.order_id
    JOIN `olist_data.sellers` s ON oi.seller_id = s.seller_id
    JOIN `olist_data.customers` c ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
        AND o.order_delivered_customer_date IS NOT NULL
    GROUP BY 1, 2
    HAVING shipment_count >= 10
)
SELECT 
    seller_state,
    customer_state,
    shipment_count,
    avg_delivery_days,
    avg_shipping_cost,
    -- SAFE_DIVIDE prevents errors if shipment_count is 0
    ROUND(SAFE_DIVIDE(on_time_deliveries, shipment_count) * 100, 2) as on_time_percentage,
    CASE 
        WHEN seller_state = customer_state THEN 'Same State'
        ELSE 'Cross-State'
    END as shipment_type
FROM delivery_analysis
ORDER BY shipment_count DESC
LIMIT 20;