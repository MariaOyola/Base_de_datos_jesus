-- ============================================
-- ELIMINAR TABLAS - BILLING
-- ============================================

DROP TABLE IF EXISTS billing.invoice_line CASCADE;
DROP TABLE IF EXISTS billing.invoice CASCADE;
DROP TABLE IF EXISTS billing.invoice_status CASCADE;
DROP TABLE IF EXISTS billing.exchange_rate CASCADE;
DROP TABLE IF EXISTS billing.tax CASCADE;