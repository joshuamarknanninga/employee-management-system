-- create_views.sql

-- View: employee_info
CREATE OR REPLACE VIEW employee_info AS
SELECT 
    employee_id,
    first_name,
    last_name,
    phone_number,
    address,
    email,
    social_security_number,
    position,
    salary,
    hire_date
FROM 
    employees;

-- View: employee_timecards
CREATE OR REPLACE VIEW employee_timecards AS
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    t.work_date,
    t.hours_worked
FROM 
    employees e
JOIN 
    timecards t ON e.employee_id = t.employee_id;
