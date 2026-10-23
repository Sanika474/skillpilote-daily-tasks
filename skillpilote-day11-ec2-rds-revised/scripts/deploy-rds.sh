#!/usr/bin/env bash
set -euo pipefail

# Usage:
# ./scripts/deploy-rds.sh <vpc-id> <subnet-id-1,subnet-id-2> <ec2-security-group-id>
# Example values must come from your own AWS account/region.
# Requires AWS CLI v2 configured with permission to create CloudFormation,
# RDS, EC2 security groups/subnet groups, and Secrets Manager resources.

if [[ $# -ne 3 ]]; then
  echo "Usage: $0 <vpc-id> <subnet-id-1,subnet-id-2> <ec2-security-group-id>"
  exit 2
fi

VPC_ID="$1"
SUBNET_IDS="$2"
EC2_SG_ID="$3"
REGION="${AWS_REGION:-ap-south-1}"
STACK_NAME="${STACK_NAME:-skillpilote-day11-rds}"

IFS=',' read -r -a SUBNET_ARRAY <<< "$SUBNET_IDS"
if [[ ${#SUBNET_ARRAY[@]} -lt 2 ]]; then
  echo "Provide at least two subnet IDs in different Availability Zones."
  exit 2
fi

aws cloudformation deploy \
  --region "$REGION" \
  --stack-name "$STACK_NAME" \
  --template-file infrastructure/rds-mysql.yaml \
  --capabilities CAPABILITY_IAM \
  --parameter-overrides \
    "VpcId=$VPC_ID" \
    "PrivateSubnetIds=$(IFS=,; echo "${SUBNET_ARRAY[*]}")" \
    "Ec2SecurityGroupId=$EC2_SG_ID"

aws cloudformation describe-stacks \
  --region "$REGION" \
  --stack-name "$STACK_NAME" \
  --query "Stacks[0].Outputs" \
  --output table
