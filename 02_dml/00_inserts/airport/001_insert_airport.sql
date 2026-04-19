-- ============================================
-- AIRPORT
-- ============================================

-- Neiva (Benito Salas - NVA)
INSERT INTO airport.airport (
    address_id,
    airport_name,
    iata_code,
    icao_code
)
SELECT 
    a.address_id,
    'Benito Salas Airport',
    'NVA',
    'SKNV'
FROM geography.address a
JOIN geography.district d ON d.district_id = a.district_id
JOIN geography.city c ON c.city_id = d.city_id
WHERE c.city_name = 'Neiva';


-- Bogotá (El Dorado - BOG)
INSERT INTO airport.airport (
    address_id,
    airport_name,
    iata_code,
    icao_code
)
SELECT 
    a.address_id,
    'El Dorado International Airport',
    'BOG',
    'SKBO'
FROM geography.address a
JOIN geography.district d ON d.district_id = a.district_id
JOIN geography.city c ON c.city_id = d.city_id
WHERE c.city_name = 'Bogota';

-- ============================================
-- TERMINAL
-- ============================================

INSERT INTO airport.terminal (
    airport_id,
    terminal_code,
    terminal_name
)
SELECT 
    ap.airport_id,
    'T1',
    'Main Terminal'
FROM airport.airport ap
WHERE ap.iata_code = 'BOG';


INSERT INTO airport.terminal (
    airport_id,
    terminal_code,
    terminal_name
)
SELECT 
    ap.airport_id,
    'T1',
    'Regional Terminal'
FROM airport.airport ap
WHERE ap.iata_code = 'NVA';

-- ============================================
-- BOARDING GATE
-- ============================================

INSERT INTO airport.boarding_gate (
    terminal_id,
    gate_code
)
SELECT 
    t.terminal_id,
    'A1'
FROM airport.terminal t
JOIN airport.airport ap ON ap.airport_id = t.airport_id
WHERE ap.iata_code = 'BOG';


INSERT INTO airport.boarding_gate (
    terminal_id,
    gate_code
)
SELECT 
    t.terminal_id,
    'B1'
FROM airport.terminal t
JOIN airport.airport ap ON ap.airport_id = t.airport_id
WHERE ap.iata_code = 'NVA';

-- ============================================
-- RUNWAY
-- ============================================

INSERT INTO airport.runway (
    airport_id,
    runway_code,
    length_meters,
    surface_type
)
SELECT 
    ap.airport_id,
    'RWY-01',
    3800,
    'ASPHALT'
FROM airport.airport ap
WHERE ap.iata_code = 'BOG';


INSERT INTO airport.runway (
    airport_id,
    runway_code,
    length_meters,
    surface_type
)
SELECT 
    ap.airport_id,
    'RWY-01',
    1600,
    'ASPHALT'
FROM airport.airport ap
WHERE ap.iata_code = 'NVA';

-- ============================================
-- AIRPORT REGULATION
-- ============================================

INSERT INTO airport.airport_regulation (
    airport_id,
    regulation_code,
    regulation_title,
    issuing_authority,
    effective_from
)
SELECT 
    ap.airport_id,
    'COL-001',
    'General Aviation Regulation',
    'Aerocivil Colombia',
    '2020-01-01'
FROM airport.airport ap
WHERE ap.iata_code = 'BOG';


INSERT INTO airport.airport_regulation (
    airport_id,
    regulation_code,
    regulation_title,
    issuing_authority,
    effective_from
)
SELECT 
    ap.airport_id,
    'COL-002',
    'Regional Airport Regulation',
    'Aerocivil Colombia',
    '2021-01-01'
FROM airport.airport ap
WHERE ap.iata_code = 'NVA';