-- Analyze shipping costs relative to product price
SELECT 
    CASE 
        WHEN price = 0 THEN 'Free Product'
        WHEN price < 50 THEN 'Under £50'
        WHEN price < 100 THEN '£50-100'
        WHEN price < 200 THEN '£100-200'
        WHEN price < 500 THEN '£200-500'
        ELSE 'Over £500'
    END as price_range,
    COUNT(*) as order_count,
    ROUND(AVG(price), 2) as avg_price,
    ROUND(AVG(freight_value), 2) as avg_shipping_cost,
    ROUND(AVG(freight_value / NULLIF(price, 0)) * 100, 2) as shipping_percent_of_price,
    ROUND(avg(date_diff(o.order_delivered_customer_date, o.order_purchase_timestamp,day)),2) as avg_delivery_days
FROM olist_data.order_items oi
JOIN olist_data.orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
    AND price > 0  -- Exclude free products
GROUP BY 1
ORDER BY MIN(price);