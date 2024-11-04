#!/bin/bash

# generate_employee_report.sh

# Load environment variables
source ../config/db_config.env

# Define output file
OUTPUT_FILE="employee_report.csv"

# Execute SQL and export to CSV
psql -U "$DB_USER" -d "$DB_NAME" -h "$DB_HOST" -p "$DB_PORT" -c "\copy (
    SELECT 
        employee_id,
        first_name,
        last_name,
        phone_number,
        address,
        email,
        'XXX-XX-' || RIGHT(social_security_number, 4) AS masked_ssn,
        position,
        salary,
        hire_date
    FROM 
        employee_info
    ORDER BY 
        last_name, first_name
) TO '$OUTPUT_FILE' CSV HEADER"

if [ $? -eq 0 ]; then
    echo "Employee report generated: $OUTPUT_FILE"
else
    echo "Failed to generate employee report."
    exit 1
fi
