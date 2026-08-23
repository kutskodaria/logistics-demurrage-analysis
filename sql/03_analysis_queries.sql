SELECT 
    c.carrier_name,
    COUNT(s.shipment_id) AS total_containers_sent,
    SUM(CASE WHEN s.actual_delivery_date <= s.planned_delivery_date THEN 1 ELSE 0 END) AS on_time_deliveries,
    ROUND((SUM(CASE WHEN s.actual_delivery_date <= s.planned_delivery_date THEN 1 ELSE 0 END) / COUNT(s.shipment_id)) * 100, 2) AS otif_percentage,
    COALESCE(SUM(dc.penalty_amount_usd), 0) AS total_demurrage_losses_usd
FROM shipments s
INNER JOIN carriers c ON s.carrier_id = c.carrier_id
LEFT JOIN demurrage_claims dc ON s.shipment_id = dc.shipment_id
GROUP BY c.carrier_name
ORDER BY otif_percentage DESC;
USE china_belarus_logistics;
SHOW TABLES;
