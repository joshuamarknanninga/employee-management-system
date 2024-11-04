-- insert_data.sql

-- Insert Employees
INSERT INTO employees (first_name, last_name, phone_number, address, email, social_security_number, position, salary)
VALUES
('John', 'Doe', '555-1234', '123 Elm Street, Springfield, IL', 'john.doe@example.com', '123-45-6789', 'Software Engineer', 90000.00),
('Jane', 'Smith', '555-5678', '456 Oak Avenue, Springfield, IL', 'jane.smith@example.com', '987-65-4321', 'Project Manager', 105000.00),
('Alice', 'Johnson', '555-8765', '789 Pine Road, Springfield, IL', 'alice.johnson@example.com', '555-55-5555', 'HR Specialist', 60000.00);

-- Insert Timecards
INSERT INTO timecards (employee_id, work_date, hours_worked)
VALUES
(1, '2024-04-01', 8.00),
(1, '2024-04-02', 8.50),
(2, '2024-04-01', 9.00),
(3, '2024-04-01', 7.50),
(3, '2024-04-02', 8.00);
