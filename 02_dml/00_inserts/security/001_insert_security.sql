-- ============================================
-- USER STATUS
-- ============================================

INSERT INTO security.user_status (status_code, status_name) VALUES
('ACTIVE', 'Active'),
('INACTIVE', 'Inactive'),
('LOCKED', 'Locked');


-- ============================================
-- SECURITY ROLE
-- ============================================

INSERT INTO security.security_role (role_code, role_name, role_description) VALUES
('ADMIN', 'Administrator', 'Full system access'),
('AGENT', 'Sales Agent', 'Handles reservations and sales'),
('CUSTOMER', 'Customer', 'End user of the platform');


-- ============================================
-- SECURITY PERMISSION
-- ============================================

INSERT INTO security.security_permission (permission_code, permission_name, permission_description) VALUES
('CREATE_USER', 'Create User', 'Allows creating users'),
('VIEW_USER', 'View User', 'Allows viewing users'),
('UPDATE_USER', 'Update User', 'Allows updating users'),
('DELETE_USER', 'Delete User', 'Allows deleting users'),

('CREATE_RESERVATION', 'Create Reservation', 'Create bookings'),
('VIEW_RESERVATION', 'View Reservation', 'View bookings');


-- ============================================
-- USER ACCOUNT
-- ============================================

INSERT INTO security.user_account (
    person_id,
    user_status_id,
    username,
    password_hash
)
SELECT 
    p.person_id,
    us.user_status_id,
    'maria.admin',
    'hashed_password_123'
FROM identity.person p
JOIN security.user_status us ON us.status_code = 'ACTIVE'
WHERE p.first_name = 'Maria';


INSERT INTO security.user_account (
    person_id,
    user_status_id,
    username,
    password_hash
)
SELECT 
    p.person_id,
    us.user_status_id,
    'carlos.agent',
    'hashed_password_456'
FROM identity.person p
JOIN security.user_status us ON us.status_code = 'ACTIVE'
WHERE p.first_name = 'Carlos';


-- ============================================
-- USER ROLE
-- ============================================

-- Maria → ADMIN
INSERT INTO security.user_role (
    user_account_id,
    security_role_id
)
SELECT 
    ua.user_account_id,
    r.security_role_id
FROM security.user_account ua
JOIN security.security_role r ON r.role_code = 'ADMIN'
WHERE ua.username = 'maria.admin';


-- Carlos → AGENT
INSERT INTO security.user_role (
    user_account_id,
    security_role_id
)
SELECT 
    ua.user_account_id,
    r.security_role_id
FROM security.user_account ua
JOIN security.security_role r ON r.role_code = 'AGENT'
WHERE ua.username = 'carlos.agent';


-- ============================================
-- ROLE PERMISSION
-- ============================================

-- ADMIN → todos los permisos
INSERT INTO security.role_permission (
    security_role_id,
    security_permission_id
)
SELECT 
    r.security_role_id,
    p.security_permission_id
FROM security.security_role r, security.security_permission p
WHERE r.role_code = 'ADMIN';


-- AGENT → solo algunos permisos
INSERT INTO security.role_permission (
    security_role_id,
    security_permission_id
)
SELECT 
    r.security_role_id,
    p.security_permission_id
FROM security.security_role r
JOIN security.security_permission p 
    ON p.permission_code IN ('CREATE_RESERVATION', 'VIEW_RESERVATION')
WHERE r.role_code = 'AGENT';