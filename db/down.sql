-- Drop tables in reverse order of creation to handle dependencies
DROP TABLE IF EXISTS maintenance_records;
DROP TABLE IF EXISTS violations;
DROP TABLE IF EXISTS compliance_checks;
DROP TABLE IF EXISTS inspectors;
DROP TABLE IF EXISTS regulations;
DROP TABLE IF EXISTS vehicles;
DROP TABLE IF EXISTS owners;
