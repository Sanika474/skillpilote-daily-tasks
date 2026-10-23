#!/usr/bin/env bash
set -euo pipefail

# Run on the EC2 instance. Pass endpoint and Secrets Manager ARN as arguments.
# Usage: ./scripts/connect-rds.sh <endpoint> <secret-arn>
# Requires AWS CLI and MariaDB/MySQL client installed, plus IAM permission
# secretsmanager:GetSecretValue for the specified secret.
if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <rds-endpoint> <credentials-secret-arn>"
  exit 2
fi

ENDPOINT="$1"
SECRET_ARN="$2"
REGION="${AWS_REGION:-ap-south-1}"

if ! command -v mysql >/dev/null 2>&1; then
  echo "mysql client not found. On Amazon Linux 2023 run: sudo dnf install mariadb105 -y"
  exit 1
fi

USERNAME="$(aws secretsmanager get-secret-value \
  --region "$REGION" \
  --secret-id "$SECRET_ARN" \
  --query SecretString \
  --output text | python3 -c 'import json,sys; print(json.load(sys.stdin)["username"])')"

# Password is not echoed or placed in the command line; mysql prompts securely.
echo "Connecting to ${ENDPOINT} as ${USERNAME}. Enter the password from Secrets Manager when prompted."
mysql -h "$ENDPOINT" -P 3306 -u "$USERNAME" -p
