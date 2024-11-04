-- create_schema.sql

-- Enable necessary extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Table: employees
CREATE TABLE IF NOT EXISTS employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(15),
    address VARCHAR(255),
    email VARCHAR(100) UNIQUE NOT NULL,
    social_security_number CHAR(11) UNIQUE NOT NULL, -- Format: XXX-XX-XXXX
    position VARCHAR(50) NOT NULL,
    salary NUMERIC(15, 2) NOT NULL,
    hire_date DATE NOT NULL DEFAULT CURRENT_DATE
);

-- Table: timecards
CREATE TABLE IF NOT EXISTS timecards (
    timecard_id SERIAL PRIMARY KEY,
    employee_id INTEGER REFERENCES employees(employee_id) ON DELETE CASCADE,
    work_date DATE NOT NULL,
    hours_worked NUMERIC(4, 2) CHECK (hours_worked >= 0 AND hours_worked <= 24)
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_timecards_employee_id ON timecards(employee_id);
CREATE INDEX IF NOT EXISTS idx_timecards_work_date ON timecards(work_date);
