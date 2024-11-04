#!/bin/bash

# setup.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Load environment variables
source ../config/db_config.env

# Step 1: Create Database
echo "Creating database..."
psql -U postgres -h "$DB_HOST" -p "$DB_PORT" -c "\i ../db/create_database.sql"

# Step 2: Create Schema
echo "Creating schema..."
psql -U "$DB_USER" -d "$DB_NAME" -h "$DB_HOST" -p "$DB_PORT" -f ../db/create_schema.sql

# Step 3: Insert Data
echo "Inserting sample data..."
psql -U "$DB_USER" -d "$DB_NAME" -h "$DB_HOST" -p "$DB_PORT" -f ../db/insert_data.sql

# Step 4: Create Views
echo "Creating views..."
psql -U "$DB_USER" -d "$DB_NAME" -h "$DB_HOST" -p "$DB_PORT" -f ../db/create_views.sql

# Step 5: Setup Security
echo "Setting up security roles and permissions..."
psql -U "$DB_USER" -d "$DB_NAME" -h "$DB_HOST" -p "$DB_PORT" -f ../db/security_setup.sql

echo "Setup completed successfully."
