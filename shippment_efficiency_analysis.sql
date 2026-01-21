-- Estimate shipping efficiency based on geographic distance
WITH state_distances AS (
    SELECT 
        s.seller_state,
        c.customer_state,
        CASE 
            WHEN s.seller_state = c.customer_state THEN 0
            ELSE 1000  -- Approximate km for cross-state shipping
        END as approx_distance_km,
        COUNT(*) as shipment_count,
        -- BigQuery DATE_DIFF (end, start, unit)
        ROUND(AVG(DATE_DIFF(o.order_delivered_customer_date, o.order_delivered_carrier_date, DAY)), 2) as avg_transit_days,
        ROUND(AVG(oi.freight_value), 2) as avg_shipping_cost
    FROM `olist_data.orders` o
    JOIN `olist_data.order_items` oi ON o.order_id = oi.order_id
    JOIN `olist_data.sellers` s ON oi.seller_id = s.seller_id
    JOIN `olist_data.customers` c ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
        AND o.order_delivered_customer_date IS NOT NULL
        AND o.order_delivered_carrier_date IS NOT NULL
    GROUP BY 1, 2, 3
    HAVING shipment_count >= 5
)
SELECT 
    seller_state,
    customer_state,
    shipment_count,
    approx_distance_km,
    avg_transit_days,
    avg_shipping_cost,
    -- SAFE_DIVIDE protects against division by zero
    ROUND(SAFE_DIVIDE(avg_shipping_cost, approx_distance_km), 4) as cost_per_km,
    ROUND(SAFE_DIVIDE(avg_transit_days, approx_distance_km) * 100, 2) as days_per_100km,
    CASE 
        WHEN SAFE_DIVIDE(avg_shipping_cost, approx_distance_km) < 0.05 THEN 'Highly Efficient'
        WHEN SAFE_DIVIDE(avg_shipping_cost, approx_distance_km) < 0.10 THEN 'Efficient'
        ELSE 'Needs Optimization'
    END as efficiency_rating
FROM state_distances
WHERE approx_distance_km > 0
ORDER BY cost_per_km DESC;