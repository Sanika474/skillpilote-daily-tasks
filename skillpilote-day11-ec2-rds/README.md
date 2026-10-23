# SkillPilote Practical — Connect EC2 to Amazon RDS for MySQL

## Aim
Connect an Amazon EC2 Linux instance to an Amazon RDS MySQL database, create a table, insert a sample record, and retrieve it to verify connectivity.

## Environment
- AWS Region: Asia Pacific (Mumbai), `ap-south-1`
- EC2 OS observed: Amazon Linux 2023
- Database engine: MySQL on Amazon RDS
- Database name: `skillpilote_db`
- Database user: `admin`
- Port: `3306`
- Client installed on EC2: MariaDB 10.5 command-line client

## Implementation performed
1. Created the RDS database instance.
2. Connected the RDS database to the EC2 compute resource using AWS connectivity configuration.
3. Checked security group connectivity for MySQL on TCP port `3306`.
4. Connected to EC2 over SSH from Windows.
5. Installed the MariaDB client on EC2 and verified it with `mysql --version`.
6. Downloaded the AWS RDS CA bundle to the EC2 home directory.
7. Connected to RDS using the endpoint, database username, and password prompt with SSL verification.
8. Verified the database list and selected `skillpilote_db`.
9. Created `practical_records`.
10. Inserted a sample record and verified it with `SELECT * FROM practical_records;`.

## Commands used

### Install the client (Amazon Linux 2023)
```bash
sudo dnf install mariadb105 -y
mysql --version
```

### Download the RDS CA bundle
```bash
curl -o global-bundle.pem https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem
```

### Connect from EC2 (replace endpoint with the value shown in RDS)
```bash
mysql -h YOUR_RDS_ENDPOINT -P 3306 -u admin -p --ssl --ssl-ca=global-bundle.pem --ssl-verify-server-cert
```

The password is entered interactively and is not stored in this repository. The command above uses MariaDB-compatible SSL options.

### SQL used for the verified sample
See [`sql/practical_records.sql`](sql/practical_records.sql).

## Verification result
The final query returned one row:

| id | student_name | practical_name |
|---:|---|---|
| 1 | Student | EC2 to RDS Connection |

This confirms that the EC2 client connected to RDS and that the sample record was inserted and retrieved.

## Evidence
Screenshots extracted from the practical report are in [`evidence/`](evidence/). See [`evidence/README.md`](evidence/README.md) for captions and ordering. The original uploaded report is retained in [`report/`](report/).

## Security and cleanup
- Never commit AWS passwords, access keys, private SSH keys (`.pem`), session tokens, or credential files.
- The endpoint is represented by a placeholder in the command; use the live endpoint only in your terminal.
- Keep RDS private and permit port `3306` only from the EC2 security group.
- After capturing evidence, delete the RDS instance if it is no longer needed. Check for retained snapshots/backups and other billable AWS resources.
