INSERT INTO billing.tax (
    tax_code,
    tax_name,
    rate_percentage,
    effective_from
) VALUES
('IVA', 'Impuesto al Valor Agregado', 19.000, '2020-01-01'),
('AIRPORT_TAX', 'Airport Tax', 8.500, '2020-01-01'),
('SERVICE_FEE', 'Service Fee', 5.000, '2020-01-01');

INSERT INTO billing.exchange_rate (
    from_currency_id,
    to_currency_id,
    effective_date,
    rate_value
)
SELECT c1.currency_id, c2.currency_id, current_date, 0.00025
FROM geography.currency c1, geography.currency c2
WHERE c1.iso_currency_code = 'COP'
  AND c2.iso_currency_code = 'USD';

INSERT INTO billing.exchange_rate (
    from_currency_id,
    to_currency_id,
    effective_date,
    rate_value
)
SELECT c1.currency_id, c2.currency_id, current_date, 4000.00000
FROM geography.currency c1, geography.currency c2
WHERE c1.iso_currency_code = 'USD'
  AND c2.iso_currency_code = 'COP';

INSERT INTO billing.invoice_status (status_code, status_name) VALUES
('DRAFT', 'Draft'),
('ISSUED', 'Issued'),
('PAID', 'Paid'),
('CANCELLED', 'Cancelled');

INSERT INTO billing.invoice (
    sale_id,
    invoice_status_id,
    currency_id,
    invoice_number,
    issued_at,
    due_at,
    notes
)
SELECT
    s.sale_id,
    st.invoice_status_id,
    c.currency_id,
    'INV-' || substr(s.sale_id::text, 1, 8),
    now(),
    now() + interval '7 days',
    'Factura generada automáticamente'
FROM sales_reservation.sale s
JOIN billing.invoice_status st ON st.status_code = 'ISSUED'
JOIN geography.currency c ON c.iso_currency_code = 'COP'
LIMIT 1;

INSERT INTO billing.invoice_line (
    invoice_id,
    tax_id,
    line_number,
    line_description,
    quantity,
    unit_price
)
SELECT
    i.invoice_id,
    t.tax_id,
    1,
    'Ticket aéreo',
    1,
    200000.00
FROM billing.invoice i
JOIN billing.tax t ON t.tax_code = 'IVA'
LIMIT 1;