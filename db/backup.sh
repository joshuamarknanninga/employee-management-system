#!/bin/bash

# backup.sh

# Load environment variables
source ../config/db_config.env

# Define backup directory
BACKUP_DIR="../backups"
mkdir -p "$BACKUP_DIR"

# Define backup file name with timestamp
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/employee_db_backup_$TIMESTAMP.sql"

# Perform the backup using pg_dump
pg_dump -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" -F c -b -v -f "$BACKUP_FILE" "$DB_NAME"

if [ $? -eq 0 ]; then
    echo "Backup successful: $BACKUP_FILE"
else
    echo "Backup failed."
    exit 1
fi
