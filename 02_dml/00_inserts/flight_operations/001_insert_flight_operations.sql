INSERT INTO flight_operations.flight_status (status_code, status_name) VALUES
('SCHEDULED', 'Scheduled'),
('BOARDING', 'Boarding'),
('DEPARTED', 'Departed'),
('ARRIVED', 'Arrived'),
('CANCELLED', 'Cancelled'),
('DELAYED', 'Delayed');

INSERT INTO flight_operations.delay_reason_type (reason_code, reason_name) VALUES
('WX', 'Weather'),
('MX', 'Technical Maintenance'),
('ATC', 'Air Traffic Control'),
('OPS', 'Operational Issues');

INSERT INTO flight_operations.flight (
    airline_id,
    aircraft_id,
    flight_status_id,
    flight_number,
    service_date
)
SELECT 
    al.airline_id,
    ac.aircraft_id,
    fs.flight_status_id,
    'AV001',
    CURRENT_DATE
FROM airline.airline al,
     aircraft.aircraft ac,
     flight_operations.flight_status fs
WHERE al.airline_code = 'AV'
AND fs.status_code = 'SCHEDULED'
LIMIT 1;

INSERT INTO flight_operations.flight_segment (
    flight_id,
    origin_airport_id,
    destination_airport_id,
    segment_number,
    scheduled_departure_at,
    scheduled_arrival_at
)
SELECT 
    f.flight_id,
    a1.airport_id,
    a2.airport_id,
    1,
    now() + interval '2 hour',
    now() + interval '3 hour'
FROM flight_operations.flight f,
     airport.airport a1,
     airport.airport a2
WHERE a1.iata_code = 'BOG'
AND a2.iata_code = 'NVA'
LIMIT 1;

INSERT INTO flight_operations.flight_delay (
    flight_segment_id,
    delay_reason_type_id,
    reported_at,
    delay_minutes,
    notes
)
SELECT 
    fs.flight_segment_id,
    dr.delay_reason_type_id,
    now(),
    30,
    'Heavy rain in departure airport'
FROM flight_operations.flight_segment fs,
     flight_operations.delay_reason_type dr
WHERE dr.reason_code = 'WX'
LIMIT 1;