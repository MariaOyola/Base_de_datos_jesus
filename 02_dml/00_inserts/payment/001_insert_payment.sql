INSERT INTO payment.payment_status (status_code, status_name) VALUES
('PENDING', 'Pending'),
('AUTHORIZED', 'Authorized'),
('CAPTURED', 'Captured'),
('FAILED', 'Failed'),
('REFUNDED', 'Refunded');

INSERT INTO payment.payment_method (method_code, method_name) VALUES
('CARD', 'Credit/Debit Card'),
('CASH', 'Cash'),
('TRANSFER', 'Bank Transfer'),
('WALLET', 'Digital Wallet');

INSERT INTO payment.payment (
    sale_id,
    payment_status_id,
    payment_method_id,
    currency_id,
    payment_reference,
    amount,
    authorized_at
)
SELECT
    s.sale_id,
    ps.payment_status_id,
    pm.payment_method_id,
    c.currency_id,
    'PAY-' || substr(s.sale_id::text, 1, 8),
    250000.00,
    now()
FROM sales_reservation.sale s
JOIN payment.payment_status ps ON ps.status_code = 'AUTHORIZED'
JOIN payment.payment_method pm ON pm.method_code = 'CARD'
JOIN geography.currency c ON c.iso_currency_code = 'COP'
LIMIT 1;

INSERT INTO payment.payment_transaction (
    payment_id,
    transaction_reference,
    transaction_type,
    transaction_amount,
    processed_at,
    provider_message
)
SELECT
    p.payment_id,
    'TX-' || substr(p.payment_id::text, 1, 10),
    'AUTH',
    p.amount,
    now(),
    'Autorización exitosa'
FROM payment.payment p;

INSERT INTO payment.refund (
    payment_id,
    refund_reference,
    amount,
    requested_at,
    processed_at,
    refund_reason
)
SELECT
    p.payment_id,
    'REF-' || substr(p.payment_id::text, 1, 10),
    p.amount * 0.5,
    now(),
    now(),
    'Reembolso parcial por cancelación'
FROM payment.payment p
LIMIT 1;