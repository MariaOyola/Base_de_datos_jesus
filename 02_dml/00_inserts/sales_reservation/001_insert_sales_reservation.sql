INSERT INTO sales_reservation.reservation_status (status_code, status_name) VALUES
('CREATED', 'Created'),
('CONFIRMED', 'Confirmed'),
('CANCELLED', 'Cancelled'),
('EXPIRED', 'Expired');

INSERT INTO sales_reservation.sale_channel (channel_code, channel_name) VALUES
('WEB', 'Website'),
('APP', 'Mobile App'),
('AGENCY', 'Travel Agency'),
('AIRPORT', 'Airport Counter');


INSERT INTO sales_reservation.fare_class (
    cabin_class_id,
    fare_class_code,
    fare_class_name,
    is_refundable_by_default
)
SELECT 
    cc.cabin_class_id,
    'Y',
    'Economy Basic',
    false
FROM aircraft.cabin_class cc
WHERE cc.class_code = 'ECON';

INSERT INTO sales_reservation.fare (
    airline_id,
    origin_airport_id,
    destination_airport_id,
    fare_class_id,
    currency_id,
    fare_code,
    base_amount,
    valid_from
)
SELECT 
    al.airline_id,
    a1.airport_id,
    a2.airport_id,
    fc.fare_class_id,
    c.currency_id,
    'FARE-AV-BOG-NVA',
    250000,
    CURRENT_DATE
FROM airline.airline al,
     airport.airport a1,
     airport.airport a2,
     sales_reservation.fare_class fc,
     geography.currency c
WHERE al.airline_code = 'AV'
AND a1.iata_code = 'BOG'
AND a2.iata_code = 'NVA'
AND c.iso_currency_code = 'COP'
LIMIT 1;

INSERT INTO sales_reservation.ticket_status (status_code, status_name) VALUES
('ISSUED', 'Issued'),
('USED', 'Used'),
('CANCELLED', 'Cancelled');


INSERT INTO sales_reservation.reservation (
    booked_by_customer_id,
    reservation_status_id,
    sale_channel_id,
    reservation_code,
    booked_at
)
SELECT 
    c.customer_id,
    rs.reservation_status_id,
    sc.sale_channel_id,
    'RES123456',
    now()
FROM loyalty.customer c,
     sales_reservation.reservation_status rs,
     sales_reservation.sale_channel sc
WHERE rs.status_code = 'CREATED'
AND sc.channel_code = 'WEB'
LIMIT 1;

INSERT INTO sales_reservation.reservation_passenger (
    reservation_id,
    person_id,
    passenger_sequence_no,
    passenger_type
)
SELECT 
    r.reservation_id,
    p.person_id,
    1,
    'ADULT'
FROM sales_reservation.reservation r,
     identity.person p
LIMIT 1;

INSERT INTO sales_reservation.sale (
    reservation_id,
    currency_id,
    sale_code,
    sold_at
)
SELECT 
    r.reservation_id,
    c.currency_id,
    'SALE123',
    now()
FROM sales_reservation.reservation r,
     geography.currency c
WHERE c.iso_currency_code = 'COP'
LIMIT 1;

INSERT INTO sales_reservation.ticket (
    sale_id,
    reservation_passenger_id,
    fare_id,
    ticket_status_id,
    ticket_number,
    issued_at
)
SELECT 
    s.sale_id,
    rp.reservation_passenger_id,
    f.fare_id,
    ts.ticket_status_id,
    'TICK123456',
    now()
FROM sales_reservation.sale s,
     sales_reservation.reservation_passenger rp,
     sales_reservation.fare f,
     sales_reservation.ticket_status ts
WHERE ts.status_code = 'ISSUED'
LIMIT 1;

INSERT INTO sales_reservation.ticket_segment (
    ticket_id,
    flight_segment_id,
    segment_sequence_no
)
SELECT 
    t.ticket_id,
    fs.flight_segment_id,
    1
FROM sales_reservation.ticket t,
     flight_operations.flight_segment fs
LIMIT 1;

INSERT INTO sales_reservation.seat_assignment (
    ticket_segment_id,
    aircraft_seat_id,
    assigned_at,
    assignment_source
)
SELECT 
    ts.ticket_segment_id,
    s.aircraft_seat_id,
    now(),
    'AUTO'
FROM sales_reservation.ticket_segment ts,
     aircraft.aircraft_seat s
LIMIT 1;

INSERT INTO sales_reservation.baggage (
    ticket_segment_id,
    baggage_tag,
    baggage_type,
    baggage_status,
    weight_kg
)
SELECT 
    ts.ticket_segment_id,
    'BG123456',
    'CHECKED',
    'REGISTERED',
    23
FROM sales_reservation.ticket_segment ts
LIMIT 1;