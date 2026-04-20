-- ============================================
-- 1. CUSTOMER CATEGORY
-- Tabla base SIN dependencias
-- Tipos de clientes
-- ============================================

INSERT INTO loyalty.customer_category (category_code, category_name) VALUES
('REGULAR', 'Regular Customer'),
('VIP', 'VIP Customer'),
('CORP', 'Corporate Customer');

-- ============================================
-- 2. BENEFIT TYPE
-- Tabla base SIN dependencias
-- Beneficios posibles
-- ============================================

INSERT INTO loyalty.benefit_type (benefit_code, benefit_name, benefit_description) VALUES
('PRIORITY_BOARDING', 'Priority Boarding', 'Board earlier than other passengers'),
('EXTRA_BAGGAGE', 'Extra Baggage', 'Additional baggage allowance'),
('LOUNGE_ACCESS', 'Lounge Access', 'Access to VIP lounges');

-- ============================================
-- 3. LOYALTY PROGRAM
-- Depende de: airline + currency
-- Programa de millas por aerolínea
-- ============================================

INSERT INTO loyalty.loyalty_program (
    airline_id,
    default_currency_id,
    program_code,
    program_name,
    expiration_months
)
SELECT 
    a.airline_id,
    c.currency_id,
    'AV_MILES',
    'Avianca LifeMiles',
    24
FROM airline.airline a, geography.currency c
WHERE a.airline_code = 'AV'
  AND c.iso_currency_code = 'COP';


-- ============================================
-- 4. LOYALTY TIER
-- Depende de: loyalty_program
-- Niveles del programa
-- ============================================

INSERT INTO loyalty.loyalty_tier (
    loyalty_program_id,
    tier_code,
    tier_name,
    priority_level,
    required_miles
)
SELECT 
    lp.loyalty_program_id,
    'SILVER',
    'Silver Tier',
    1,
    10000
FROM loyalty.loyalty_program lp
WHERE lp.program_code = 'AV_MILES';


INSERT INTO loyalty.loyalty_tier (
    loyalty_program_id,
    tier_code,
    tier_name,
    priority_level,
    required_miles
)
SELECT 
    lp.loyalty_program_id,
    'GOLD',
    'Gold Tier',
    2,
    30000
FROM loyalty.loyalty_program lp
WHERE lp.program_code = 'AV_MILES';

-- ============================================
-- 5. CUSTOMER
-- Depende de: airline + person + customer_category
-- Convierte personas en clientes de la aerolínea
-- ============================================

INSERT INTO loyalty.customer (
    airline_id,
    person_id,
    customer_category_id
)
SELECT 
    a.airline_id,
    p.person_id,
    cc.customer_category_id
FROM airline.airline a
JOIN identity.person p ON p.first_name = 'Maria'
JOIN loyalty.customer_category cc ON cc.category_code = 'VIP'
WHERE a.airline_code = 'AV';


INSERT INTO loyalty.customer (
    airline_id,
    person_id,
    customer_category_id
)
SELECT 
    a.airline_id,
    p.person_id,
    cc.customer_category_id
FROM airline.airline a
JOIN identity.person p ON p.first_name = 'Carlos'
JOIN loyalty.customer_category cc ON cc.category_code = 'REGULAR'
WHERE a.airline_code = 'AV';

-- ============================================
-- 6. LOYALTY ACCOUNT
-- Depende de: customer + loyalty_program
-- Cuenta de millas del cliente
-- ============================================

INSERT INTO loyalty.loyalty_account (
    customer_id,
    loyalty_program_id,
    account_number
)
SELECT 
    c.customer_id,
    lp.loyalty_program_id,
    'ACC-0001'
FROM loyalty.customer c
JOIN loyalty.loyalty_program lp ON lp.program_code = 'AV_MILES'
JOIN identity.person p ON p.person_id = c.person_id
WHERE p.first_name = 'Maria';


INSERT INTO loyalty.loyalty_account (
    customer_id,
    loyalty_program_id,
    account_number
)
SELECT 
    c.customer_id,
    lp.loyalty_program_id,
    'ACC-0002'
FROM loyalty.customer c
JOIN loyalty.loyalty_program lp ON lp.program_code = 'AV_MILES'
JOIN identity.person p ON p.person_id = c.person_id
WHERE p.first_name = 'Carlos';

-- ============================================
-- 7. LOYALTY ACCOUNT TIER
-- Depende de: loyalty_account + loyalty_tier
-- Nivel actual del cliente
-- ============================================

INSERT INTO loyalty.loyalty_account_tier (
    loyalty_account_id,
    loyalty_tier_id,
    assigned_at
)
SELECT 
    la.loyalty_account_id,
    lt.loyalty_tier_id,
    now()
FROM loyalty.loyalty_account la
JOIN loyalty.loyalty_tier lt ON lt.tier_code = 'GOLD'
JOIN loyalty.customer c ON c.customer_id = la.customer_id
JOIN identity.person p ON p.person_id = c.person_id
WHERE p.first_name = 'Maria';


INSERT INTO loyalty.loyalty_account_tier (
    loyalty_account_id,
    loyalty_tier_id,
    assigned_at
)
SELECT 
    la.loyalty_account_id,
    lt.loyalty_tier_id,
    now()
FROM loyalty.loyalty_account la
JOIN loyalty.loyalty_tier lt ON lt.tier_code = 'SILVER'
JOIN loyalty.customer c ON c.customer_id = la.customer_id
JOIN identity.person p ON p.person_id = c.person_id
WHERE p.first_name = 'Carlos';

-- ============================================
-- 8. MILES TRANSACTION
-- Depende de: loyalty_account
-- Movimiento de millas
-- ============================================

INSERT INTO loyalty.miles_transaction (
    loyalty_account_id,
    transaction_type,
    miles_delta,
    occurred_at,
    reference_code
)
SELECT 
    la.loyalty_account_id,
    'EARN',
    5000,
    now(),
    'FLIGHT-001'
FROM loyalty.loyalty_account la
JOIN loyalty.customer c ON c.customer_id = la.customer_id
JOIN identity.person p ON p.person_id = c.person_id
WHERE p.first_name = 'Maria';

-- ============================================
-- 9. CUSTOMER BENEFIT
-- Depende de: customer + benefit_type
-- Beneficios asignados al cliente
-- ============================================

INSERT INTO loyalty.customer_benefit (
    customer_id,
    benefit_type_id,
    granted_at
)
SELECT 
    c.customer_id,
    bt.benefit_type_id,
    now()
FROM loyalty.customer c
JOIN identity.person p ON p.person_id = c.person_id
JOIN loyalty.benefit_type bt ON bt.benefit_code = 'LOUNGE_ACCESS'
WHERE p.first_name = 'Maria';