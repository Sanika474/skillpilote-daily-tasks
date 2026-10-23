# SkillPilote Day 11 — EC2 to Amazon RDS for MySQL

## Aim
Provision a managed Amazon RDS MySQL database, restrict access to the intended EC2 security group, connect from EC2, and verify a sample insert/query.

## Repository contents
- `infrastructure/rds-mysql.yaml` — CloudFormation template that creates an RDS MySQL instance, DB subnet group, RDS security group, and a generated master credential secret in AWS Secrets Manager.
- `scripts/deploy-rds.sh` — deploys the CloudFormation template through AWS CLI.
- `scripts/connect-rds.sh` — retrieves the username from Secrets Manager and connects using the MySQL-compatible CLI. The password is entered interactively.
- `sql/practical_records.sql` — SQL to create the table, insert the sample row, and query it.
- `evidence/` — screenshots captured during the practical.
- `report/` — supplied practical report.

## Prerequisites
1. AWS CLI v2 installed and configured with an IAM identity that has permission to create CloudFormation stacks, RDS resources, EC2 security groups, subnet groups, and Secrets Manager secrets.
2. An existing VPC and at least two subnet IDs in different Availability Zones for the RDS DB subnet group.
3. The EC2 instance security group ID that should be allowed to connect to RDS.
4. Use the same AWS Region for the VPC, subnets, EC2 instance, and RDS. The lab used `ap-south-1` (Mumbai).

## Deploy infrastructure
Run from the repository root in Bash/Git Bash/WSL. Supply IDs from your own AWS account; do not copy identifiers from someone else's account.

```bash
chmod +x scripts/deploy-rds.sh scripts/connect-rds.sh
export AWS_REGION=ap-south-1
./scripts/deploy-rds.sh vpc-REPLACE_ME subnet-REPLACE_ME1,subnet-REPLACE_ME2 sg-REPLACE_ME
```

The template:
- Creates a managed MySQL 8.0 RDS DB instance.
- Creates a DB subnet group from the supplied subnets.
- Sets `PubliclyAccessible: false`.
- Allows TCP `3306` only from the supplied EC2 security group.
- Generates a password in AWS Secrets Manager rather than hard-coding it in source.
- Uses encrypted gp3 storage and a single-AZ instance for a lower-cost lab configuration.

**Before deployment:** validate the template, check that the selected DB instance class is available in your region/account, and review the current AWS estimate. RDS and Secrets Manager can incur charges. Two subnets must be in different Availability Zones; choose private subnets where possible.

Optional validation:
```bash
aws cloudformation validate-template --template-body file://infrastructure/rds-mysql.yaml --region ap-south-1
```

## Connect from EC2
After the CloudFormation stack completes, note `DBEndpointAddress` and `CredentialsSecretArn` from its outputs. Ensure the EC2 instance has network access to the RDS subnets and an IAM role allowing `secretsmanager:GetSecretValue` for the generated secret.

```bash
./scripts/connect-rds.sh <DBEndpointAddress> <CredentialsSecretArn>
```

The script prompts for the database password; retrieve it from the AWS Secrets Manager console for this secret. Never put the password into a command, README, screenshot, or Git repository.

For Amazon Linux 2023, install the MariaDB client:
```bash
sudo dnf install mariadb105 -y
mysql --version
```

## Run the SQL verification
After connecting, run the statements in `sql/practical_records.sql` or paste them manually. The expected sample row is:

| id | student_name | practical_name |
|---:|---|---|
| 1 | Student | EC2 to RDS Connection |

The insert statement adds a new row each time it is run. For repeatable verification without duplicate rows, remove/comment out the `INSERT` statement after the first successful run.

## Clean up
When the lab is complete, delete the CloudFormation stack if the resources were created by this template:
```bash
aws cloudformation delete-stack --stack-name skillpilote-day11-rds --region ap-south-1
aws cloudformation wait stack-delete-complete --stack-name skillpilote-day11-rds --region ap-south-1
```
Review the stack's resources and any retained backups/snapshots before deletion. If you created the RDS instance manually outside this stack, delete it separately after confirming you no longer need it. Also check for other billable AWS resources.

## Security notes
- Do not commit `.pem` files, AWS credentials, passwords, session tokens, or local `.env` files.
- Do not expose port `3306` to `0.0.0.0/0`.
- Use an IAM role with least-privilege permissions for the EC2 instance.
- The CloudFormation template has deletion protection disabled for this temporary lab; do not use that setting for production databases without reviewing requirements.

## Result
The manual practical successfully connected EC2 to RDS, inserted a sample record into `skillpilote_db.practical_records`, and retrieved it with `SELECT`. The infrastructure template and scripts in this repository make the provisioning process reproducible, subject to account-specific parameters and AWS permissions.
