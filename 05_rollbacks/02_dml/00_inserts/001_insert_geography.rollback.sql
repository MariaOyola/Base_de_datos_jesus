-- HIJOS PRIMERO
DELETE FROM geography.address;
WHERE address_line_1 IN (
'Calle 7 #5-23',
'Carrera 7 #72-41'
);

DELETE FROM geography.district;
WHERE district_name IN ('Centro','Chapinero','Downtown');

DELETE FROM geography.city;
WHERE city_name IN ('Neiva','Bogota','Los Angeles','Madrid');

DELETE FROM geography.state_province;
WHERE state_code IN ('HUI','CUN','CA','MD');

DELETE FROM geography.country;
WHERE iso_alpha2 IN ('CO','US','ES','JP');




-- PADRES DESPUÉS
DELETE FROM geography.continent;
WHERE continent_code IN ('SA','NA','EU','AS','AF');

DELETE FROM geography.time_zone;
WHERE time_zone_name IN (
'UTC',
'America/Bogota',
'America/New_York',
'America/Los_Angeles',
'Europe/Madrid',
'Asia/Tokyo'
);
DELETE FROM geography.currency;
WHERE iso_currency_code IN ('COP','USD','EUR','JPY');