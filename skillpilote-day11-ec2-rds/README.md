# SkillPilote Day 11 — Connect EC2 to Amazon RDS

## Practical objective
Connect an existing EC2 web server to an Amazon RDS for MySQL database, create a test database and table, insert one sample record, and query it to confirm the connection.

> **Status note:** This repository contains the practical files and instructions. Do not claim the live AWS connection was completed until you have actually run the commands and captured your own successful output/screenshots.

## Architecture
`EC2 Apache server` → private network connection on TCP `3306` → `Amazon RDS for MySQL`

## AWS resources noted during preparation
- Region: `ap-south-1` (Mumbai)
- Existing EC2 instance name: `SkillPilote-Apache-Server`
- Instance type: `t3.micro`
- EC2 instance ID: `i-08451c7911d958e6f`
- EC2 VPC: `vpc-082185a0fbb302aef`
- EC2 subnet: `subnet-09342d17a9d77d4ed`
- EC2 private IP: `172.31.9.134`
- EC2 state at preparation: **Stopped**
- RDS database at preparation: **None listed**

## Important billing and security notes
- RDS can incur charges while running, including for database compute, storage, backups, and related options. Check the current AWS pricing and account eligibility before creating it.
- A stopped EC2 instance may still incur EBS storage and other associated charges.
- Keep RDS **not publicly accessible** for this practical.
- Do not open MySQL port `3306` to `0.0.0.0/0`.
- Do not commit passwords, access keys, `.env` files, private keys, or credential screenshots to GitHub.
- Do not put a real database password or endpoint in this README. Use your own values locally.

## Procedure

### 1. Check EC2 and RDS region
1. Open the AWS Console and select **Asia Pacific (Mumbai) — `ap-south-1`**.
2. Confirm the existing EC2 instance is the intended web server.
3. Confirm whether an RDS database already exists before creating one.

### 2. Create the RDS database (only if you choose to proceed)
In RDS → Databases → Create database:
- Creation method: Full configuration
- Engine: MySQL
- Deployment: Single-AZ / Single DB instance for a basic lab, if available
- DB identifier: `skillpilote-day11-db`
- Master username: choose a username such as `admin`
- Master password: create a strong, unique password and keep it private
- Connectivity: use the same VPC as EC2 (`vpc-082185a0fbb302aef`)
- Public access: **No**
- Initial database name (if the form offers it): `skillpilote_test`

Choose the smallest configuration that is actually offered and appropriate for your account. A “Free tier” label does not guarantee that every selected feature or resource is free. Review the estimated cost before creating the database.

### 3. Configure security groups
1. Identify the security group attached to EC2.
2. Create or select an RDS security group in the same VPC.
3. Add an **inbound** rule to the RDS security group:
   - Type: MySQL/Aurora
   - Protocol: TCP
   - Port: `3306`
   - Source: the **EC2 security group ID**, not `0.0.0.0/0`
4. Attach the RDS security group to the RDS instance.
5. Do not add port 3306 to the EC2 inbound rules unless there is a separate, justified requirement.

### 4. Start and connect to EC2
Start the existing EC2 instance only when ready to perform the practical. Connect using the method configured for that instance. If SSH is used, protect your private key and do not upload it to GitHub.

### 5. Install the MySQL command-line client
Choose the command that matches the EC2 operating system.

**Amazon Linux 2023:**
```bash
sudo dnf install mariadb105 -y
```

**Amazon Linux 2:**
```bash
sudo yum install mariadb -y
```

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install mysql-client -y
```

Confirm the client is available:
```bash
mysql --version
```

### 6. Connect to RDS
Copy the RDS endpoint from RDS → Databases → your database → Connectivity & security. Use the endpoint hostname only; do not include `https://` or a port in the hostname field.

Run this command, replacing the placeholder with your real endpoint:
```bash
mysql -h YOUR_RDS_ENDPOINT -P 3306 -u admin -p
```

Enter the database password at the prompt. Do not put the password directly in the command. If the connection fails, verify the endpoint, database status, VPC, security-group source rule, and route/network settings. Do not make RDS publicly accessible as a quick fix.

### 7. Create the database, table, and sample row
At the MySQL prompt, execute the SQL in [`sql/day11.sql`](sql/day11.sql), or paste the statements manually.

Expected sample query:
```sql
SELECT id, name, note FROM skillpilote_test.sample_records;
```

Expected result should contain one row with name `Day 11 Sample` and note `EC2 to RDS connection verified`.

### 8. Capture evidence
Save your own screenshots in `evidence/`, such as:
1. RDS database status and endpoint (hide sensitive details if needed; never show passwords).
2. EC2 terminal showing `mysql --version`.
3. Successful MySQL connection prompt.
4. `SELECT` query and returned sample row.
5. GitHub repository page showing the uploaded files.

Do not create fake screenshots or report an unperformed step as completed.

### 9. Upload to GitHub
From PowerShell, navigate to the extracted folder:
```powershell
cd path\to\skillpilote-day11-ec2-rds
git init
git add README.md sql evidence .gitignore
git commit -m "Add SkillPilote Day 11 EC2 to RDS practical"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPOSITORY.git
git push -u origin main
```

If you are adding these files to an **existing** repository, open that repository's folder and copy the `README.md`, `sql` and `evidence` contents into it instead of running `git init` again. Do not overwrite existing work without checking it first.

## Cleanup after the practical
When finished:
1. Save evidence and verify GitHub upload.
2. If the RDS database is no longer needed, delete it only after confirming you do not need the data. Review backup/snapshot choices and any possible charges.
3. Stop EC2 if it is no longer needed; stopping it does not remove EBS storage charges.
4. Check RDS, EC2, EBS volumes, snapshots, Elastic IPs, NAT gateways, and other resources in the region to avoid unexpected charges.
