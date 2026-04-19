INSERT INTO airline.airline (home_country_id, airline_code, airline_name, iata_code, icao_code)
SELECT country_id, 'AV', 'Avianca', 'AV', 'AVA'
FROM geography.country WHERE iso_alpha2 = 'CO';

INSERT INTO airline.airline (home_country_id, airline_code, airline_name, iata_code, icao_code)
SELECT country_id, 'LA', 'LATAM Colombia', 'LA', 'LAN'
FROM geography.country WHERE iso_alpha2 = 'CO';


INSERT INTO airline.airline (home_country_id, airline_code, airline_name, iata_code, icao_code)
SELECT country_id, 'AA', 'American Airlines', 'AA', 'AAL'
FROM geography.country WHERE iso_alpha2 = 'US';

INSERT INTO airline.airline (home_country_id, airline_code, airline_name, iata_code, icao_code)
SELECT country_id, 'DL', 'Delta Air Lines', 'DL', 'DAL'
FROM geography.country WHERE iso_alpha2 = 'US';

INSERT INTO airline.airline (home_country_id, airline_code, airline_name, iata_code, icao_code)
SELECT country_id, 'IB', 'Iberia', 'IB', 'IBE'
FROM geography.country WHERE iso_alpha2 = 'ES';


INSERT INTO airline.airline (home_country_id, airline_code, airline_name, iata_code, icao_code)
SELECT country_id, 'NH', 'All Nippon Airways', 'NH', 'ANA'
FROM geography.country WHERE iso_alpha2 = 'JP';

INSERT INTO airline.airline (home_country_id, airline_code, airline_name, iata_code, icao_code)
SELECT country_id, 'JL', 'Japan Airlines', 'JL', 'JAL'
FROM geography.country WHERE iso_alpha2 = 'JP';