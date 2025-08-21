-- Pahana Edu Billing System Database
-- Created for ICBT CIS6003 S3SRI WRIT1 Project

-- Create database
CREATE DATABASE IF NOT EXISTS pahanaedu;
USE pahanaedu;

-- Drop tables if they exist (for clean setup)
DROP TABLE IF EXISTS bill_items;
DROP TABLE IF EXISTS bills;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS settings;

-- Create users table
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('ADMIN', 'STAFF') NOT NULL DEFAULT 'STAFF',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create customers table
CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    customerType ENUM('INDIVIDUAL', 'BUSINESS', 'STUDENT') DEFAULT 'INDIVIDUAL',
    address TEXT,
    city VARCHAR(100),
    postalCode VARCHAR(20),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create items table
CREATE TABLE items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stockQuantity INT NOT NULL DEFAULT 0,
    description TEXT,
    category ENUM('BOOKS', 'STATIONERY', 'ELECTRONICS', 'UNIFORMS', 'SPORTS', 'OTHER') DEFAULT 'OTHER',
    sku VARCHAR(50),
    status ENUM('ACTIVE', 'INACTIVE', 'DISCONTINUED') DEFAULT 'ACTIVE',
    supplier VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create settings table
CREATE TABLE settings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    setting_key VARCHAR(100) UNIQUE NOT NULL,
    setting_value TEXT,
    setting_type ENUM('STRING', 'NUMBER', 'BOOLEAN', 'JSON') DEFAULT 'STRING',
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create bills table
CREATE TABLE bills (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    total DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    bill_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('PENDING', 'PAID', 'CANCELLED') DEFAULT 'PENDING',
    created_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL
);

-- Create bill_items table (junction table for bills and items)
CREATE TABLE bill_items (
    bill_item_id INT PRIMARY KEY AUTO_INCREMENT,
    bill_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    line_total DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (bill_id) REFERENCES bills(id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES items(id) ON DELETE CASCADE
);

-- Insert sample users
INSERT INTO users (username, password, role) VALUES
('admin', 'admin123', 'ADMIN'),
('staff1', 'staff123', 'STAFF'),
('staff2', 'staff456', 'STAFF'),
('manager', 'manager123', 'ADMIN');

-- Insert sample customers
INSERT INTO customers (name, email, phone, customerType, address, city, postalCode, notes) VALUES
('Sihara Dewmini', 'Sihara.dew@email.com', '077-2345678', 'INDIVIDUAL', '123 Main Street, Colombo 01', 'Colombo', '10000', 'Regular customer'),
('Imandi Adikari', 'Imandi.a@email.com', '077-3456789', 'STUDENT', '456 Oak Avenue, Kandy', 'Kandy', '20000', 'Student discount applied'),
('Maalan Sangeeth', 'maalan.sangeeth@email.com', '077-4567890', 'BUSINESS', '789 Pine Road, Galle', 'Galle', '80000', 'Business account'),
('Dheshanth Perera', 'Dheshanthp@email.com', '077-5678901', 'STUDENT', '321 Elm Street, Jaffna', 'Jaffna', '40000', 'University student'),
('Kasuni Rajapaksha', 'Kasuni.R@email.com', '077-6789012', 'INDIVIDUAL', '654 Maple Drive, Anuradhapura', 'Anuradhapura', '50000', 'New customer'),
('Kalani Rajapaksha', 'Kalani.R@email.com', '077-7890123', 'INDIVIDUAL', '987 Cedar Lane, Matara', 'Matara', '81000', 'Prefers email communication'),
('Kavindu Bandara', 'Kavindu.B@email.com', '077-8901234', 'BUSINESS', '147 Birch Court, Kurunegala', 'Kurunegala', '60000', 'School supplies order'),
('Janani Chathurika', 'janani.2003@email.com', '077-9012345', 'STUDENT', '258 Spruce Way, Ratnapura', 'Ratnapura', '70000', 'Online course student');

-- Insert sample items (educational products and services)
INSERT INTO items (name, price, stockQuantity, description, category, sku, status, supplier) VALUES
('Mathematics Textbook Grade 10', 1250.00, 50, 'Comprehensive mathematics textbook for grade 10 students', 'BOOKS', 'MATH-10-001', 'ACTIVE', 'Educational Publishers Ltd'),
('Science Lab Kit', 3500.00, 25, 'Complete science laboratory kit for practical experiments', 'ELECTRONICS', 'SCI-LAB-001', 'ACTIVE', 'Science Equipment Co'),
('English Grammar Workbook', 850.00, 75, 'Interactive English grammar workbook with exercises', 'BOOKS', 'ENG-GRAM-001', 'ACTIVE', 'Language Learning Press'),
('Computer Programming Course', 15000.00, 30, '3-month programming course with certificate', 'OTHER', 'PROG-COURSE-001', 'ACTIVE', 'Tech Education Institute'),
('Art Supplies Set', 2200.00, 40, 'Complete art supplies including paints, brushes, and canvas', 'STATIONERY', 'ART-SUP-001', 'ACTIVE', 'Creative Supplies Ltd'),
('Physics Calculator', 1800.00, 35, 'Scientific calculator for physics and mathematics', 'ELECTRONICS', 'CALC-PHYS-001', 'ACTIVE', 'Scientific Instruments'),
('History Study Guide', 950.00, 60, 'Comprehensive history study guide for O/L students', 'BOOKS', 'HIST-SG-001', 'ACTIVE', 'Academic Publishers'),
('Music Instrument - Guitar', 8500.00, 15, 'Acoustic guitar for music classes', 'OTHER', 'MUSIC-GUITAR-001', 'ACTIVE', 'Music World'),
('Chemistry Lab Manual', 1200.00, 45, 'Laboratory manual for chemistry practical work', 'BOOKS', 'CHEM-LAB-001', 'ACTIVE', 'Science Publishers'),
('Sports Equipment Set', 4200.00, 20, 'Complete sports equipment for physical education', 'SPORTS', 'SPORTS-EQ-001', 'ACTIVE', 'Sports Equipment Co'),
('Library Membership', 500.00, 100, 'Annual library membership with access to all resources', 'OTHER', 'LIB-MEM-001', 'ACTIVE', 'Pahana Edu Library'),
('Online Tutoring Session', 2000.00, 50, 'One-hour online tutoring session with qualified teachers', 'OTHER', 'TUTOR-ONLINE-001', 'ACTIVE', 'Pahana Edu Tutors'),
('School Uniform Set', 3500.00, 80, 'Complete school uniform including shirt, pants, and tie', 'UNIFORMS', 'UNIFORM-SET-001', 'ACTIVE', 'Uniform Suppliers Ltd'),
('Stationery Pack', 750.00, 120, 'Complete stationery pack with notebooks, pens, and pencils', 'STATIONERY', 'STATIONERY-PACK-001', 'ACTIVE', 'Office Supplies Co'),
('Computer Skills Workshop', 8000.00, 25, '2-day computer skills workshop for beginners', 'OTHER', 'COMP-WORKSHOP-001', 'ACTIVE', 'Tech Training Center');

-- Insert sample settings
INSERT INTO settings (setting_key, setting_value, setting_type, description) VALUES
('company_name', 'Pahana Edu Billing System', 'STRING', 'Company name for invoices and reports'),
('company_address', '123 Education Street, Colombo 01, Sri Lanka', 'STRING', 'Company address for invoices'),
('company_phone', '+94-11-1234567', 'STRING', 'Company phone number'),
('company_email', 'info@pahanaedu.com', 'STRING', 'Company email address'),
('email_notifications', 'true', 'BOOLEAN', 'Enable email notifications for low stock alerts'),
('auto_backup', 'true', 'BOOLEAN', 'Enable automatic database backup'),
('stock_alerts', 'true', 'BOOLEAN', 'Show low stock warnings'),
('low_stock_threshold', '10', 'NUMBER', 'Minimum stock quantity before showing low stock alert'),
('currency', 'LKR', 'STRING', 'Default currency for the system'),
('tax_rate', '15', 'NUMBER', 'Default tax rate percentage'),
('invoice_prefix', 'INV-', 'STRING', 'Prefix for invoice numbers'),
('last_backup_date', '2024-01-01 00:00:00', 'STRING', 'Last database backup date');

-- Insert sample bills
INSERT INTO bills (customer_id, total, bill_date, status, created_by) VALUES
(1, 4500.00, '2024-01-15 10:30:00', 'PAID', 2),
(2, 12500.00, '2024-01-16 14:20:00', 'PAID', 2),
(3, 8500.00, '2024-01-17 09:15:00', 'PENDING', 3),
(4, 3200.00, '2024-01-18 16:45:00', 'PAID', 2),
(5, 15000.00, '2024-01-19 11:30:00', 'PENDING', 3),
(6, 7500.00, '2024-01-20 13:20:00', 'PAID', 2),
(7, 4200.00, '2024-01-21 15:10:00', 'CANCELLED', 3),
(8, 9800.00, '2024-01-22 10:45:00', 'PAID', 2);

-- Insert sample bill items
INSERT INTO bill_items (bill_id, item_id, quantity, unit_price, line_total) VALUES
-- Bill 1 items
(1, 1, 2, 1250.00, 2500.00),
(1, 3, 1, 850.00, 850.00),
(1, 14, 2, 750.00, 1500.00),

-- Bill 2 items
(2, 4, 1, 15000.00, 15000.00),
(2, 12, 1, 2000.00, 2000.00),

-- Bill 3 items
(3, 2, 1, 3500.00, 3500.00),
(3, 6, 1, 1800.00, 1800.00),
(3, 9, 1, 1200.00, 1200.00),
(3, 11, 1, 500.00, 500.00),

-- Bill 4 items
(4, 5, 1, 2200.00, 2200.00),
(4, 14, 1, 750.00, 750.00),
(4, 11, 1, 500.00, 500.00),

-- Bill 5 items
(5, 4, 1, 15000.00, 15000.00),

-- Bill 6 items
(6, 8, 1, 8500.00, 8500.00),
(6, 12, 1, 2000.00, 2000.00),

-- Bill 7 items (cancelled)
(7, 10, 1, 4200.00, 4200.00),

-- Bill 8 items
(8, 1, 3, 1250.00, 3750.00),
(8, 3, 2, 850.00, 1700.00),
(8, 7, 1, 950.00, 950.00),
(8, 13, 1, 3500.00, 3500.00);

-- Create indexes for better performance
CREATE INDEX idx_bills_customer_id ON bills(customer_id);
CREATE INDEX idx_bills_date ON bills(bill_date);
CREATE INDEX idx_bills_status ON bills(status);
CREATE INDEX idx_bill_items_bill_id ON bill_items(bill_id);
CREATE INDEX idx_bill_items_item_id ON bill_items(item_id);
CREATE INDEX idx_items_category ON items(category);
CREATE INDEX idx_customers_name ON customers(name);

-- Create view for bill details with customer and item information
CREATE VIEW bill_details AS
SELECT 
    b.id as bill_id,
    b.bill_date,
    b.total,
    b.status,
    c.name as customer_name,
    c.phone as customer_phone,
    c.email as customer_email,
    c.customerType as customer_type,
    u.username as created_by_user
FROM bills b
JOIN customers c ON b.customer_id = c.id
LEFT JOIN users u ON b.created_by = u.id;

-- Create view for bill items with item details
CREATE VIEW bill_items_details AS
SELECT 
    bi.bill_item_id,
    bi.bill_id,
    bi.item_id,
    bi.quantity,
    bi.unit_price,
    bi.line_total,
    i.name as item_name,
    i.category as item_category
FROM bill_items bi
JOIN items i ON bi.item_id = i.id;

-- Grant permissions (adjust as needed for your environment)
-- GRANT ALL PRIVILEGES ON pahanaedu.* TO 'root'@'localhost';
-- FLUSH PRIVILEGES;

-- Display summary
SELECT 'Database setup completed successfully!' as status;
SELECT COUNT(*) as total_users FROM users;
SELECT COUNT(*) as total_customers FROM customers;
SELECT COUNT(*) as total_items FROM items;
SELECT COUNT(*) as total_bills FROM bills;
SELECT COUNT(*) as total_bill_items FROM bill_items;
SELECT COUNT(*) as total_settings FROM settings;
