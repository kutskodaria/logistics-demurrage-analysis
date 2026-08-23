
CREATE DATABASE IF NOT EXISTS china_belarus_logistics;
USE china_belarus_logistics;

DROP TABLE IF EXISTS demurrage_claims;
DROP TABLE IF EXISTS shipments;
DROP TABLE IF EXISTS routes;
DROP TABLE IF EXISTS carriers;

CREATE TABLE carriers (
    carrier_id INT AUTO_INCREMENT PRIMARY KEY,
    carrier_name VARCHAR(100) NOT NULL,
    country_origin VARCHAR(50)
);

CREATE TABLE routes (
    route_id INT AUTO_INCREMENT PRIMARY KEY,
    pol VARCHAR(100),
    pod VARCHAR(100),
    planned_lead_time_days INT NOT NULL
);

CREATE TABLE shipments (
    shipment_id INT AUTO_INCREMENT PRIMARY KEY,
    container_number VARCHAR(11) NOT NULL,
    carrier_id INT,
    route_id INT,
    dispatch_date DATE NOT NULL,
    planned_delivery_date DATE NOT NULL,
    actual_delivery_date DATE,
    freight_cost_usd DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (carrier_id) REFERENCES carriers(carrier_id) ON DELETE CASCADE,
    FOREIGN KEY (route_id) REFERENCES routes(route_id) ON DELETE CASCADE
);

CREATE TABLE demurrage_claims (
    claim_id INT AUTO_INCREMENT PRIMARY KEY,
    shipment_id INT,
    free_days_allowed INT DEFAULT 7,
    actual_days_at_station INT,
    penalty_amount_usd DECIMAL(10, 2) DEFAULT 0.00,
    FOREIGN KEY (shipment_id) REFERENCES shipments(shipment_id) ON DELETE CASCADE
);

INSERT INTO carriers (carrier_name, country_origin) VALUES 
('Sinotrans Heavy', 'China'),
('RZD Logistics', 'Russia'),
('Eurasia Rail Express', 'Belarus');

INSERT INTO routes (pol, pod, planned_lead_time_days) VALUES 
('Ningbo (CNSHA)', 'Kolyadichi (BYMSK)', 22),
('Shanghai (CNSHA)', 'Kolyadichi (BYMSK)', 20),
('Guangzhou (CNCAN)', 'Kolyadichi (BYMSK)', 25);
