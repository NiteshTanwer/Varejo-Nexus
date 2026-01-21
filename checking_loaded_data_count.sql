-- Check row counts
SELECT 'orders' AS table_name, COUNT(*) AS row_count FROM olist_data.orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM olist_data.order_items
UNION ALL
SELECT 'products', COUNT(*) FROM olist_data.products
UNION ALL
SELECT 'sellers', COUNT(*) FROM olist_data.sellers
UNION ALL
SELECT 'geolocation', COUNT(*) FROM olist_data.geolocation
UNION ALL
SELECT 'customers', COUNT(*) FROM olist_data.customers
UNION ALL
SELECT 'order_payments', COUNT(*) FROM olist_data.order_payments
UNION ALL
SELECT 'order_reviews', COUNT(*)
FROM olist_data.order_reviews
ORDER BY table_name;
