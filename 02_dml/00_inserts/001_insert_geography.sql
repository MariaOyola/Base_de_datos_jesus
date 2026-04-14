INSERT INTO geography.time_zone 
(time_zone_name, utc_offset_minutes, created_by, updated_by)
VALUES
('UTC', 0, gen_random_uuid(), gen_random_uuid()),
('America/Bogota', -300, gen_random_uuid(), gen_random_uuid()),
('America/New_York', -300, gen_random_uuid(), gen_random_uuid()),
('Europe/Madrid', 60, gen_random_uuid(), gen_random_uuid()),
('Asia/Tokyo', 540, gen_random_uuid(), gen_random_uuid()),
('Australia/Sydney', 600, gen_random_uuid(), gen_random_uuid());