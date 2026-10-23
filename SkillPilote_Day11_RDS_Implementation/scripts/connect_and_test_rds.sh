#!/usr/bin/env bash
set -euo pipefail

# Run on the EC2 Linux instance after installing the MySQL client.
# Set DB_HOST to the RDS endpoint shown in CloudFormation outputs.
# The password is prompted interactively; it is not embedded in this script.

if [[ -z "${DB_HOST:-}" ]]; then
  echo "Set DB_HOST to the RDS endpoint hostname first."
  echo 'Example: export DB_HOST="your-rds-endpoint.rds.amazonaws.com"'
  exit 1
fi

DB_PORT="${DB_PORT:-3306}"
DB_USER="${DB_USER:-dbadmin}"

if ! command -v mysql >/dev/null 2>&1; then
  echo "MySQL client not found. On Amazon Linux 2023, try:"
  echo "  sudo dnf install mariadb105 -y"
  exit 1
fi

read -r -s -p "Enter RDS password for ${DB_USER}: " DB_PASSWORD
echo
export MYSQL_PWD="$DB_PASSWORD"
trap 'unset MYSQL_PWD DB_PASSWORD' EXIT

mysql --connect-timeout=10 \
  --host="$DB_HOST" \
  --port="$DB_PORT" \
  --user="$DB_USER" \
  --protocol=TCP <<'SQL'
CREATE DATABASE IF NOT EXISTS skillpilote_demo;
USE skillpilote_demo;

CREATE TABLE IF NOT EXISTS practical_records (
  id INT AUTO_INCREMENT PRIMARY KEY,
  message VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO practical_records (message)
VALUES ('Day 11 EC2 to RDS connection test');

SELECT id, message, created_at
FROM practical_records
ORDER BY id DESC
LIMIT 5;
SQL

echo "If the query returned rows, the EC2-to-RDS MySQL test succeeded."
