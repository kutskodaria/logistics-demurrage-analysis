USE china_belarus_logistics;

DROP PROCEDURE IF EXISTS generate_logistics_data;

DELIMITER //

CREATE PROCEDURE generate_logistics_data()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE v_carrier_id INT;
    DECLARE v_route_id INT;
    DECLARE v_dispatch_date DATE;
    DECLARE v_planned_date DATE;
    DECLARE v_actual_date DATE;
    DECLARE v_lead_time INT;
    DECLARE v_delay INT;
    DECLARE v_freight_cost DECIMAL(10,2);
    DECLARE v_container VARCHAR(11);
    DECLARE v_shipment_id INT;
    DECLARE v_penalty DECIMAL(10,2);
    DECLARE v_actual_days_at_station INT;

    SET FOREIGN_KEY_CHECKS = 0;
    TRUNCATE TABLE demurrage_claims;
    TRUNCATE TABLE shipments;
    SET FOREIGN_KEY_CHECKS = 1;

    WHILE i <= 500 DO
        SET v_container = CONCAT('MSCU', 1000000 + i);
        
        SET v_carrier_id = 1 + FLOOR(RAND() * 3);
        SET v_route_id = 1 + FLOOR(RAND() * 3);
        
        SELECT planned_lead_time_days INTO v_lead_time FROM routes WHERE route_id = v_route_id;

        SET v_dispatch_date = DATE_ADD('2024-01-01', INTERVAL FLOOR(RAND() * 700) DAY);
        SET v_planned_date = DATE_ADD(v_dispatch_date, INTERVAL v_lead_time DAY);

        IF v_carrier_id = 1 AND RAND() < 0.70 THEN
            SET v_delay = 5 + FLOOR(RAND() * 12);
        ELSE
            SET v_delay = FLOOR(RAND() * 5) - 2;
        END IF;

        SET v_actual_date = DATE_ADD(v_planned_date, INTERVAL v_delay DAY);
        SET v_freight_cost = 3000.00 + (v_route_id * 300.00) + (FLOOR(RAND() * 400) - 200);

        INSERT INTO shipments (container_number, carrier_id, route_id, dispatch_date, planned_delivery_date, actual_delivery_date, freight_cost_usd)
        VALUES (v_container, v_carrier_id, v_route_id, v_dispatch_date, v_planned_date, v_actual_date, v_freight_cost);
        
        SET v_shipment_id = LAST_INSERT_ID();

        IF v_delay > 5 THEN
            SET v_actual_days_at_station = 7 + (v_delay - 3);
            SET v_penalty = (v_actual_days_at_station - 7) * 50.00;
            
            INSERT INTO demurrage_claims (shipment_id, free_days_allowed, actual_days_at_station, penalty_amount_usd)
            VALUES (v_shipment_id, 7, v_actual_days_at_station, v_penalty);
        END IF;

        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;
CALL generate_logistics_data();
SELECT COUNT(*) FROM shipments;
