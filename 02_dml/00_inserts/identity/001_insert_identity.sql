-- ============================================
-- PERSON TYPE
-- ============================================

INSERT INTO identity.person_type (type_code, type_name) VALUES
('NAT', 'Natural Person'),
('LEG', 'Legal Entity');

-- ============================================
-- DOCUMENT TYPE
-- ============================================

INSERT INTO identity.document_type (type_code, type_name) VALUES
('CC', 'Citizenship ID'),
('PP', 'Passport'),
('NIT', 'Tax ID');

-- ============================================
-- CONTACT TYPE
-- ============================================

INSERT INTO identity.contact_type (type_code, type_name) VALUES
('EMAIL', 'Email Address'),
('PHONE', 'Phone Number'),
('MOBILE', 'Mobile Phone');

-- ============================================
-- PERSON
-- ============================================

INSERT INTO identity.person (
    person_type_id,
    nationality_country_id,
    first_name,
    last_name,
    birth_date,
    gender_code
)
SELECT 
    pt.person_type_id,
    c.country_id,
    'Maria',
    'Rodriguez',
    '2000-05-10',
    'F'
FROM identity.person_type pt, geography.country c
WHERE pt.type_code = 'NAT'
  AND c.iso_alpha2 = 'CO';


INSERT INTO identity.person (
    person_type_id,
    nationality_country_id,
    first_name,
    last_name,
    birth_date,
    gender_code
)
SELECT 
    pt.person_type_id,
    c.country_id,
    'Carlos',
    'Lopez',
    '1995-08-20',
    'M'
FROM identity.person_type pt, geography.country c
WHERE pt.type_code = 'NAT'
  AND c.iso_alpha2 = 'CO';


-- ============================================
-- PERSON DOCUMENT
-- ============================================

INSERT INTO identity.person_document (
    person_id,
    document_type_id,
    issuing_country_id,
    document_number,
    issued_on
)
SELECT 
    p.person_id,
    dt.document_type_id,
    c.country_id,
    '123456789',
    '2018-01-01'
FROM identity.person p
JOIN identity.document_type dt ON dt.type_code = 'CC'
JOIN geography.country c ON c.iso_alpha2 = 'CO'
WHERE p.first_name = 'Maria';


INSERT INTO identity.person_document (
    person_id,
    document_type_id,
    issuing_country_id,
    document_number,
    issued_on
)
SELECT 
    p.person_id,
    dt.document_type_id,
    c.country_id,
    '987654321',
    '2017-01-01'
FROM identity.person p
JOIN identity.document_type dt ON dt.type_code = 'CC'
JOIN geography.country c ON c.iso_alpha2 = 'CO'
WHERE p.first_name = 'Carlos';


-- ============================================
-- PERSON CONTACT
-- ============================================

INSERT INTO identity.person_contact (
    person_id,
    contact_type_id,
    contact_value,
    is_primary
)
SELECT 
    p.person_id,
    ct.contact_type_id,
    'maria@email.com',
    true
FROM identity.person p
JOIN identity.contact_type ct ON ct.type_code = 'EMAIL'
WHERE p.first_name = 'Maria';


INSERT INTO identity.person_contact (
    person_id,
    contact_type_id,
    contact_value,
    is_primary
)
SELECT 
    p.person_id,
    ct.contact_type_id,
    '3001234567',
    true
FROM identity.person p
JOIN identity.contact_type ct ON ct.type_code = 'MOBILE'
WHERE p.first_name = 'Carlos';