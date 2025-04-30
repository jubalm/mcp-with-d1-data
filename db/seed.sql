-- Insert sample data into owners table
INSERT INTO owners (owner_id, name, contact_info) VALUES
    (1, 'John Doe', '{"phone": "123-456-7890", "email": "johndoe@example.com", "address": "123 Elm Street"}'),
    (2, 'Jane Smith', '{"phone": "987-654-3210", "email": "janesmith@example.com", "address": "456 Oak Avenue"}'),
    (3, 'Alice Cooper', '{"phone": "555-111-2222", "email": "alice.cooper@example.com", "address": "789 Pine Lane"}'),
    (4, 'Bob Marley', '{"phone": "555-333-4444", "email": "bob.marley@example.com", "address": "321 Maple Drive"}'),
    (5, 'Charlie Brown', '{"phone": "555-555-6666", "email": "charlie.brown@example.com", "address": "654 Birch Road"}');

-- Insert sample data into vehicles table
INSERT INTO vehicles (vehicle_id, make, model, year, vin, owner_id) VALUES
    (1, 'Toyota', 'Camry', 2020, '1HGBH41JXMN109186', 1),
    (2, 'Tesla', 'Model 3', 2022, '5YJ3E1EA7LF123456', 2),
    (3, 'Ford', 'F-150', 2019, '1FTFW1ET9EKF12345', 3),
    (4, 'Honda', 'Civic', 2018, '2HGFC2F59KH512345', 4),
    (5, 'Chevrolet', 'Malibu', 2021, '1G1ZD5STXMF123456', 5);

-- Insert sample data into regulations table
INSERT INTO regulations (regulation_id, title, description, effective_date, expiry_date) VALUES
    (1, 'Emission Standards 2025', 'Maximum allowable CO2 emissions for passenger vehicles.', '2025-01-01', '2030-12-31'),
    (2, 'Brake System Safety', 'Minimum performance requirements for braking systems.', '2023-01-01', NULL);

-- Insert sample data into inspectors table
INSERT INTO inspectors (inspector_id, name, certifications, contact_info) VALUES
    (1, 'Inspector Gadget', '{"certifications": ["ISO 9001", "Brake Systems Specialist"]}', '{"phone": "555-123-4567", "email": "inspector.gadget@example.com"}'),
    (2, 'Sarah Connor', '{"certifications": ["Advanced Vehicle Safety", "Emission Compliance"]}', '{"phone": "555-987-6543", "email": "sarah.connor@example.com"}');

-- Insert sample data into compliance checks table
INSERT INTO compliance_checks (compliance_id, vehicle_id, regulation_id, check_date, status, notes, inspector_id) VALUES
    (1, 1, 1, '2025-04-20 10:00:00', 'PASS', 'Vehicle passed emission standards.', 2),
    (2, 2, 2, '2025-04-21 14:30:00', 'FAIL', 'Brake fluid levels too low.', 1);

-- Insert sample data into violations table
INSERT INTO violations (violation_id, compliance_id, description, severity, penalty) VALUES
    (1, 2, 'Brake fluid below minimum levels.', 'HIGH', 500.00);

-- Insert sample data into maintenance records table
INSERT INTO maintenance_records (maintenance_id, vehicle_id, date, details, cost) VALUES
    (1, 2, '2025-04-22 09:00:00', 'Brake fluid refilled and system checked.', 150.00);
