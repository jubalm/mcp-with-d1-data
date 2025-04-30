-- Create table for vehicle owners
CREATE TABLE owners (
    owner_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    contact_info TEXT NOT NULL
);

-- Create table for vehicles
CREATE TABLE vehicles (
    vehicle_id INTEGER PRIMARY KEY AUTOINCREMENT,
    make TEXT NOT NULL,
    model TEXT NOT NULL,
    year INTEGER NOT NULL CHECK (year >= 1886),
    vin TEXT UNIQUE NOT NULL,
    owner_id INTEGER,
    FOREIGN KEY (owner_id) REFERENCES owners(owner_id) ON DELETE SET NULL
);

-- Create table for safety regulations
CREATE TABLE regulations (
    regulation_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    effective_date TEXT NOT NULL,
    expiry_date TEXT
);

-- Create table for inspectors
CREATE TABLE inspectors (
    inspector_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    certifications TEXT NOT NULL,
    contact_info TEXT NOT NULL
);

-- Create table for compliance checks
CREATE TABLE compliance_checks (
    compliance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    vehicle_id INTEGER NOT NULL,
    regulation_id INTEGER NOT NULL,
    check_date TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status TEXT NOT NULL CHECK (status IN ('PASS', 'FAIL')),
    notes TEXT,
    inspector_id INTEGER,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id) ON DELETE CASCADE,
    FOREIGN KEY (regulation_id) REFERENCES regulations(regulation_id) ON DELETE CASCADE,
    FOREIGN KEY (inspector_id) REFERENCES inspectors(inspector_id) ON DELETE SET NULL
);

-- Create table for violations
CREATE TABLE violations (
    violation_id INTEGER PRIMARY KEY AUTOINCREMENT,
    compliance_id INTEGER NOT NULL,
    description TEXT NOT NULL,
    severity TEXT NOT NULL CHECK (severity IN ('LOW', 'MEDIUM', 'HIGH')),
    penalty REAL
);

-- Create table for maintenance records
CREATE TABLE maintenance_records (
    maintenance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    vehicle_id INTEGER NOT NULL,
    date TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    details TEXT NOT NULL,
    cost REAL,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id) ON DELETE CASCADE
);

-- Indexes for faster lookup
CREATE INDEX idx_vehicle_owner ON vehicles(owner_id);
CREATE INDEX idx_compliance_vehicle ON compliance_checks(vehicle_id);
CREATE INDEX idx_compliance_regulation ON compliance_checks(regulation_id);
CREATE INDEX idx_violation_compliance ON violations(compliance_id);
CREATE INDEX idx_maintenance_vehicle ON maintenance_records(vehicle_id);









