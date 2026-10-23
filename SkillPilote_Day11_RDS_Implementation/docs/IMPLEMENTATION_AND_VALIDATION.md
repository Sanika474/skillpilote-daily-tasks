# Implementation and validation checklist

## Before deployment
1. Verify AWS billing/Free Tier/credits and the RDS price for the chosen region and class.
2. Identify the EC2 instance's VPC ID and security group ID.
3. Select at least two subnets from that VPC in different Availability Zones.
4. Do not deploy if the estimated cost is unacceptable.

## Deploy with CloudFormation
1. AWS Console → CloudFormation → Create stack → With new resources (standard).
2. Upload `infrastructure/rds-mysql.yaml`.
3. Enter stack name `skillpilote-day11-rds`.
4. Fill `VpcId`, `Ec2SecurityGroupId`, and `PrivateSubnetIds`.
5. Enter a strong temporary `DBMasterPassword` in the secure parameter field; do not commit it.
6. Review the estimate and create only if you approve the cost.
7. Wait for `CREATE_COMPLETE`. Record the endpoint output.

## Test from EC2
1. Connect to the EC2 instance.
2. Install the MySQL client if needed: `sudo dnf install mariadb105 -y`.
3. Set the endpoint from CloudFormation outputs:
   `export DB_HOST="your-rds-endpoint"`
4. Run the script from the folder:
   `bash scripts/connect_and_test_rds.sh`
5. Enter the password when prompted. Verify the query returns the sample record.
6. Capture genuine screenshots of the stack `CREATE_COMPLETE`, RDS endpoint details (hide secrets), successful Linux query, and returned row.

## Cleanup
1. Keep the evidence locally and in the repository.
2. CloudFormation → select the stack → Delete.
3. Confirm deletion completes.
4. Check RDS, EC2, EBS volumes, snapshots, and billing for remaining resources. Stop/terminate EC2 only when no longer needed.
5. A deleted RDS database cannot be recovered when no final snapshot is retained.

## GitHub
From the root of the existing `skillpilote-daily-tasks` repository:
```cmd
git add SkillPilote_Day11_RDS_Implementation
git status
git diff --cached --stat
git commit -m "Day 11: Add RDS infrastructure and Linux test script"
git push origin main
```
