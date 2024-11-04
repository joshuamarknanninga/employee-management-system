#!/bin/bash

# generate_timecard_report.sh

# Load environment variables
source ../config/db_config.env

# Check if YEAR_MONTH is provided
if [ -z "$1" ]; then
    echo "Usage: $0 YYYY-MM"
    exit 1
fi

YEAR_MONTH=$1
OUTPUT_FILE="timecard_report_${YEAR_MONTH}.csv"

# Execute SQL and export to CSV
psql -U "$DB_USER" -d "$DB_NAME" -h "$DB_HOST" -p "$DB_PORT" -c "\copy (
    SELECT 
        e.employee_id,
        e.first_name || ' ' || e.last_name AS employee_name,
        t.work_date,
        t.hours_worked
    FROM 
        employee_timecards t
    JOIN 
        employee_info e ON t.employee_id = e.employee_id
    WHERE 
        to_char(t.work_date, 'YYYY-MM') = '$YEAR_MONTH'
    ORDER BY 
        e.employee_id, t.work_date
) TO '$OUTPUT_FILE' CSV HEADER"

if [ $? -eq 0 ]; then
    echo "Timecard report generated: $OUTPUT_FILE"
else
    echo "Failed to generate timecard report."
    exit 1
fi
