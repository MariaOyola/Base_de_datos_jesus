-- ============================================
-- GEOGRAPHY SEED DATA (DATOS REALES)
-- ============================================

-- ============================================
-- 1. TIME ZONE
-- Tabla base SIN dependencias
-- Define zonas horarias del sistema
-- ============================================

INSERT INTO geography.time_zone (time_zone_name, utc_offset_minutes) VALUES
('UTC', 0),
('America/Bogota', -300),
('America/New_York', -300),
('America/Los_Angeles', -480),
('Europe/Madrid', 60),
('Asia/Tokyo', 540);

-- ============================================
-- 2. CONTINENT
-- Tabla base SIN dependencias
-- Continentes del mundo
-- ============================================

INSERT INTO geography.continent (continent_code, continent_name) VALUES
('SA', 'South America'),
('NA', 'North America'),
('EU', 'Europe'),
('AS', 'Asia'),
('AF', 'Africa');

-- ============================================
-- 3. COUNTRY
-- Depende de: continent
-- Usa SELECT para evitar escribir IDs manuales
-- ============================================

INSERT INTO geography.country (continent_id, iso_alpha2, iso_alpha3, country_name)
SELECT continent_id, 'CO', 'COL', 'Colombia'
FROM geography.continent WHERE continent_code = 'SA';

INSERT INTO geography.country (continent_id, iso_alpha2, iso_alpha3, country_name)
SELECT continent_id, 'US', 'USA', 'United States'
FROM geography.continent WHERE continent_code = 'NA';

INSERT INTO geography.country (continent_id, iso_alpha2, iso_alpha3, country_name)
SELECT continent_id, 'ES', 'ESP', 'Spain'
FROM geography.continent WHERE continent_code = 'EU';

INSERT INTO geography.country (continent_id, iso_alpha2, iso_alpha3, country_name)
SELECT continent_id, 'JP', 'JPN', 'Japan'
FROM geography.continent WHERE continent_code = 'AS';


-- ============================================
-- 4. STATE / PROVINCE
-- Depende de: country
-- ============================================

INSERT INTO geography.state_province (country_id, state_code, state_name)
SELECT country_id, 'HUI', 'Huila'
FROM geography.country WHERE iso_alpha2 = 'CO';

INSERT INTO geography.state_province (country_id, state_code, state_name)
SELECT country_id, 'CUN', 'Cundinamarca'
FROM geography.country WHERE iso_alpha2 = 'CO';

INSERT INTO geography.state_province (country_id, state_code, state_name)
SELECT country_id, 'CA', 'California'
FROM geography.country WHERE iso_alpha2 = 'US';

INSERT INTO geography.state_province (country_id, state_code, state_name)
SELECT country_id, 'MD', 'Madrid'
FROM geography.country WHERE iso_alpha2 = 'ES';

-- ============================================
-- 5. CITY
-- Depende de: state_province + time_zone
-- Se hace JOIN implícito para obtener IDs
-- ============================================


INSERT INTO geography.city (state_province_id, time_zone_id, city_name)
SELECT sp.state_province_id, tz.time_zone_id, 'Neiva'
FROM geography.state_province sp, geography.time_zone tz
WHERE sp.state_name = 'Huila' AND tz.time_zone_name = 'America/Bogota';

INSERT INTO geography.city (state_province_id, time_zone_id, city_name)
SELECT sp.state_province_id, tz.time_zone_id, 'Bogota'
FROM geography.state_province sp, geography.time_zone tz
WHERE sp.state_name = 'Cundinamarca' AND tz.time_zone_name = 'America/Bogota';

INSERT INTO geography.city (state_province_id, time_zone_id, city_name)
SELECT sp.state_province_id, tz.time_zone_id, 'Los Angeles'
FROM geography.state_province sp, geography.time_zone tz
WHERE sp.state_name = 'California' AND tz.time_zone_name = 'America/Los_Angeles';

INSERT INTO geography.city (state_province_id, time_zone_id, city_name)
SELECT sp.state_province_id, tz.time_zone_id, 'Madrid'
FROM geography.state_province sp, geography.time_zone tz
WHERE sp.state_name = 'Madrid' AND tz.time_zone_name = 'Europe/Madrid';

-- ============================================
-- 6. DISTRICT
-- Depende de: city
-- ============================================

INSERT INTO geography.district (city_id, district_name)
SELECT city_id, 'Centro'
FROM geography.city WHERE city_name = 'Neiva';

INSERT INTO geography.district (city_id, district_name)
SELECT city_id, 'Chapinero'
FROM geography.city WHERE city_name = 'Bogota';

INSERT INTO geography.district (city_id, district_name)
SELECT city_id, 'Downtown'
FROM geography.city WHERE city_name = 'Los Angeles';

-- ============================================
-- 7. ADDRESS
-- Depende de: district
-- Incluye coordenadas geográficas
-- ============================================

INSERT INTO geography.address (district_id, address_line_1, postal_code, latitude, longitude)
SELECT district_id, 'Calle 7 #5-23', '410001', 2.9273, -75.2819
FROM geography.district WHERE district_name = 'Centro';

INSERT INTO geography.address (district_id, address_line_1, postal_code, latitude, longitude)
SELECT district_id, 'Carrera 7 #72-41', '110221', 4.7110, -74.0721
FROM geography.district WHERE district_name = 'Chapinero';

-- ============================================
-- 8. CURRENCY
-- Tabla base SIN dependencias
-- Monedas del sistema
-- ============================================

INSERT INTO geography.currency (iso_currency_code, currency_name, currency_symbol, minor_units) VALUES
('COP', 'Colombian Peso', '$', 2),
('USD', 'US Dollar', '$', 2),
('EUR', 'Euro', '€', 2),
('JPY', 'Japanese Yen', '¥', 0);