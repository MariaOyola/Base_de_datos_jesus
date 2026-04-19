INSERT INTO boarding.boarding_group (group_code, group_name, sequence_no) VALUES
('G1', 'Priority', 1),
('G2', 'Business Class', 2),
('G3', 'Economy Plus', 3),
('G4', 'Economy', 4);

INSERT INTO boarding.check_in_status (status_code, status_name) VALUES
('PENDING', 'Pending Check-in'),
('CHECKED_IN', 'Checked In'),
('CANCELLED', 'Cancelled'),
('NO_SHOW', 'No Show');

INSERT INTO boarding.check_in (
    ticket_segment_id,
    check_in_status_id,
    boarding_group_id,
    checked_in_by_user_id,
    checked_in_at
)
SELECT 
    ts.ticket_segment_id,
    cis.check_in_status_id,
    bg.boarding_group_id,
    ua.user_account_id,
    now()
FROM sales_reservation.ticket_segment ts
CROSS JOIN boarding.check_in_status cis
CROSS JOIN boarding.boarding_group bg
CROSS JOIN security.user_account ua
WHERE cis.status_code = 'CHECKED_IN'
LIMIT 1;

INSERT INTO boarding.boarding_pass (
    check_in_id,
    boarding_pass_code,
    barcode_value,
    issued_at
)
SELECT 
    ci.check_in_id,
    'BP-' || substr(ci.check_in_id::text, 1, 8),
    'BARCODE-' || substr(ci.check_in_id::text, 1, 12),
    now()
FROM boarding.check_in ci;

INSERT INTO boarding.boarding_validation (
    boarding_pass_id,
    boarding_gate_id,
    validated_by_user_id,
    validated_at,
    validation_result,
    notes
)
SELECT 
    bp.boarding_pass_id,
    bg.boarding_gate_id,
    ua.user_account_id,
    now(),
    'APPROVED',
    'Validación automática'
FROM boarding.boarding_pass bp
CROSS JOIN airport.boarding_gate bg
CROSS JOIN security.user_account ua
LIMIT 1;