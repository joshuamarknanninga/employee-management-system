#!/bin/bash

# restore_backup.sh

# Load environment variables
source ../config/db_config.env

# Check if backup file is provided
if [ -z "$1" ]; then
    echo "Usage: $0 path_to_backup_file"
    exit 1
fi

BACKUP_FILE=$1

# Check if the backup file exists
if [ ! -f "$BACKUP_FILE" ]; then
    echo "Backup file not found: $BACKUP_FILE"
    exit 1
fi

# Drop the existing database
echo "Dropping existing database..."
psql -U postgres -h "$DB_HOST" -p "$DB_PORT" -c "DROP DATABASE IF EXISTS $DB_NAME;"

# Create the database
echo "Creating database..."
psql -U postgres -h "$DB_HOST" -p "$DB_PORT" -c "\i ../db/create_database.sql"

# Restore the backup
echo "Restoring backup..."
pg_restore -U "$DB_USER" -d "$DB_NAME" -h "$DB_HOST" -p "$DB_PORT" -v "$BACKUP_FILE"

echo "Database restored successfully."
