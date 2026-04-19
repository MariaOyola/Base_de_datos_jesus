INSERT INTO aircraft.aircraft_manufacturer (manufacturer_name) VALUES
('Boeing'),
('Airbus'),
('Embraer');

INSERT INTO aircraft.aircraft_model (
    aircraft_manufacturer_id,
    model_code,
    model_name,
    max_range_km
)
SELECT am.aircraft_manufacturer_id, 'B737', 'Boeing 737-800', 5436
FROM aircraft.aircraft_manufacturer am WHERE manufacturer_name = 'Boeing';

INSERT INTO aircraft.aircraft_model (
    aircraft_manufacturer_id,
    model_code,
    model_name,
    max_range_km
)
SELECT am.aircraft_manufacturer_id, 'A320', 'Airbus A320', 6100
FROM aircraft.aircraft_manufacturer am WHERE manufacturer_name = 'Airbus';

INSERT INTO aircraft.aircraft_model (
    aircraft_manufacturer_id,
    model_code,
    model_name,
    max_range_km
)

SELECT am.aircraft_manufacturer_id, 'E190', 'Embraer 190', 4500
FROM aircraft.aircraft_manufacturer am WHERE manufacturer_name = 'Embraer';

INSERT INTO aircraft.cabin_class (class_code, class_name) VALUES
('ECON', 'Economy'),
('BUS', 'Business'),
('FIRST', 'First Class');


INSERT INTO aircraft.aircraft (
    airline_id,
    aircraft_model_id,
    registration_number,
    serial_number,
    in_service_on
)
SELECT 
    al.airline_id,
    am.aircraft_model_id,
    'HK-1234',
    'SN-BOEING-001',
    '2018-01-01'
FROM airline.airline al, aircraft.aircraft_model am
WHERE al.airline_code = 'AV'
AND am.model_code = 'B737'
LIMIT 1;


INSERT INTO aircraft.aircraft_cabin (
    aircraft_id,
    cabin_class_id,
    cabin_code,
    deck_number
)
SELECT 
    a.aircraft_id,
    cc.cabin_class_id,
    'ECON-1',
    1
FROM aircraft.aircraft a, aircraft.cabin_class cc
WHERE cc.class_code = 'ECON'
LIMIT 1;

INSERT INTO aircraft.aircraft_seat (
    aircraft_cabin_id,
    seat_row_number,
    seat_column_code,
    is_window,
    is_aisle
)
SELECT 
    ac.aircraft_cabin_id,
    1,
    'A',
    true,
    false
FROM aircraft.aircraft_cabin ac
LIMIT 1;

INSERT INTO aircraft.aircraft_seat (
    aircraft_cabin_id,
    seat_row_number,
    seat_column_code,
    is_window,
    is_aisle
)
SELECT 
    ac.aircraft_cabin_id,
    1,
    'C',
    false,
    true
FROM aircraft.aircraft_cabin ac
LIMIT 1;

INSERT INTO aircraft.maintenance_provider (
    address_id,
    provider_name,
    contact_name
)
SELECT 
    address_id,
    'LATAM Maintenance',
    'Carlos Perez'
FROM geography.address
LIMIT 1;

INSERT INTO aircraft.maintenance_type (type_code, type_name) VALUES
('A_CHECK', 'A Check'),
('B_CHECK', 'B Check'),
('C_CHECK', 'C Check');

INSERT INTO aircraft.maintenance_event (
    aircraft_id,
    maintenance_type_id,
    maintenance_provider_id,
    status_code,
    started_at
)
SELECT 
    a.aircraft_id,
    mt.maintenance_type_id,
    mp.maintenance_provider_id,
    'PLANNED',
    now()
FROM aircraft.aircraft a,
     aircraft.maintenance_type mt,
     aircraft.maintenance_provider mp
LIMIT 1;