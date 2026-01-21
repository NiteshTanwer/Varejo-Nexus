SELECT
  COUNT(*) - COUNT(order_id) AS missing_order_id,
  COUNT(*) - COUNT(order_status) AS missing_order_status,
  COUNT(*) - COUNT(customer_id) AS missing_customer_id,
  COUNT(*) - COUNT(order_purchase_timestamp) AS missing_timestamp,
  COUNT(*) - COUNT(order_delivered_carrier_date) AS missing_delivery_dates
FROM olist_data.orders;
