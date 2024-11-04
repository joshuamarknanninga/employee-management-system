#!/bin/bash

# generate_payroll_report.sh

# Load environment variables
source ../config/db_config.env

# Check if YEAR_MONTH is provided
if [ -z "$1" ]; then
    echo "Usage: $0 YYYY-MM"
    exit 1
fi

YEAR_MONTH=$1
OUTPUT_FILE="payroll_report_${YEAR_MONTH}.csv"

# Execute SQL and export to CSV
psql -U "$DB_USER" -d "$DB_NAME" -h "$DB_HOST" -p "$DB_PORT" -c "\copy (
    SELECT 
        e.employee_id,
        e.first_name || ' ' || e.last_name AS employee_name,
        e.position,
        e.salary,
        SUM(t.hours_worked) AS total_hours,
        ROUND((e.salary / 2080) * SUM(t.hours_worked), 2) AS calculated_pay
    FROM 
        employee_timecards t
    JOIN 
        employee_info e ON t.employee_id = e.employee_id
    WHERE 
        to_char(t.work_date, 'YYYY-MM') = '$YEAR_MONTH'
    GROUP BY 
        e.employee_id, e.first_name, e.last_name, e.position, e.salary
    ORDER BY 
        e.employee_id
) TO '$OUTPUT_FILE' CSV HEADER"

if [ $? -eq 0 ]; then
    echo "Payroll report generated: $OUTPUT_FILE"
else
    echo "Failed to generate payroll report."
    exit 1
fi
