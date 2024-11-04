-- create_database.sql

-- Connect to the default 'postgres' database to create a new database
\connect postgres

-- Create the employee_db database
CREATE DATABASE employee_db
    WITH 
    OWNER = employee_admin
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
