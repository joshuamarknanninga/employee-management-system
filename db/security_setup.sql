-- security_setup.sql

-- Create a read-only role for report users
CREATE ROLE report_user WITH LOGIN PASSWORD 'reportP@ss';

-- Grant necessary privileges
GRANT CONNECT ON DATABASE employee_db TO report_user;
GRANT USAGE ON SCHEMA public TO report_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO report_user;

-- Ensure future tables are also granted SELECT on creation
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO report_user;
