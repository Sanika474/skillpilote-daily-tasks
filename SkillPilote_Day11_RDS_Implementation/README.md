# SkillPilote Day 11 — EC2 to RDS implementation files

This folder adds implementation artifacts missing from a report-only submission:
- `infrastructure/rds-mysql.yaml`: AWS CloudFormation template for a private MySQL RDS instance and security group.
- `scripts/connect_and_test_rds.sh`: Linux shell script to connect from EC2 and run a demonstration SQL workflow.
- `sql/day11.sql`: SQL schema and sample record.
- `docs/IMPLEMENTATION_AND_VALIDATION.md`: deployment and evidence checklist.

## Important status
These are source files, not proof of a successful deployment. You must deploy the template, connect from EC2, run the test script, and capture genuine success screenshots before claiming the full practical is complete.

## Cost warning
Deploying the CloudFormation template creates a billable RDS instance and related resources. Check your AWS account's Free Tier/credits and the price estimate first. Delete the stack after the practical if you do not need the resources. Stack deletion deletes the RDS instance because `DeletionPolicy: Delete` is set; the template also sets backup retention to zero and does not request a final snapshot. Data will be lost when deleted.

## Security
- RDS is private (`PubliclyAccessible: false`).
- The RDS security group allows TCP 3306 only from the EC2 security group supplied as a parameter.
- CloudFormation marks the password parameter `NoEcho`; still do not put passwords in command history, Git, screenshots, or source files.
- Do not upload `.pem` keys, AWS access keys, credentials, or real passwords.
- Supply at least two subnets in different Availability Zones for the RDS subnet group.
