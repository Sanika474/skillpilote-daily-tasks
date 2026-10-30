# Day 18 – Amazon EFS Integration with EC2 and AWS Backup

## 1. Objective

To configure Amazon Elastic File System (EFS), mount it on an Amazon EC2 instance using the NFS protocol, verify file sharing, and protect the EFS file system using AWS Backup.

## 2. Technologies Used

- Amazon EC2
- Amazon Elastic File System (EFS)
- AWS Backup
- AWS Identity and Access Management (IAM)
- Network File System (NFS v4.1)
- AWS Systems Manager (SSM)
- AWS CLI
- Windows PowerShell
- Amazon Linux 2023

## 3. AWS Configuration

| Configuration | Details |
|---|---|
| AWS Region | ap-south-1 (Mumbai) |
| EC2 Instance ID | i-087c48d26bc0ac044 |
| EC2 Instance Name | SkillPilote-Day18-EFS-Server |
| EC2 Instance Type | t3.micro |
| EFS File System ID | fs-0ecb209ac72349db0 |
| EFS Name | SkillPilote-Day18-EFS |
| EFS Mount Target IP | 172.31.10.217 |
| Mount Directory | /mnt/efs |
| EFS Security Group | SkillPilote-Day18-EFS-SG |
| NFS Port | TCP 2049 |
| Backup Vault | SkillPilote-Day18-EFS-Vault |
| Backup Plan | SkillPilote-Day18-EFS-Plan |
| Backup Selection | SkillPilote-Day18-EFS-Selection |

## 4. Implementation Steps

### Step 1: Configure EC2 Instance

1. Open the AWS Management Console.
2. Navigate to Amazon EC2.
3. Launch or select the Amazon Linux 2023 EC2 instance.
4. Configure the required security group.
5. Attach an IAM role with the AmazonSSMManagedInstanceCore policy.
6. Verify that the instance is accessible through AWS Systems Manager.

### Step 2: Create EFS Security Group

1. Navigate to EC2 → Security Groups.
2. Create a security group named `SkillPilote-Day18-EFS-SG`.
3. Select the same VPC as the EC2 instance.
4. Add an inbound rule:
   - Type: NFS
   - Protocol: TCP
   - Port: 2049
   - Source: EC2 security group
5. Save the configuration.

### Step 3: Create Amazon EFS

1. Open Amazon EFS.
2. Create a new file system.
3. Set the name to `SkillPilote-Day18-EFS`.
4. Select General Purpose performance mode.
5. Enable encryption at rest.
6. Configure the mount target in the EC2 instance's VPC and subnet.
7. Associate the EFS security group.
8. Verify that the file system becomes available.

### Step 4: Install NFS Utilities

Connect to the EC2 instance using AWS Systems Manager Session Manager.

Execute:

```bash
sudo dnf install -y nfs-utils
```

Create the mount directory:

```bash
sudo mkdir -p /mnt/efs
```

### Step 5: Mount EFS on EC2

Mount the EFS file system using NFS:

```bash
sudo mount -t nfs4 -o nfsvers=4.1, rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 172.31.10.217:/ /mnt/efs
```

Verify the mount:

```bash
df -hT /mnt/efs
```

Check the mounted file system:

```bash
mount | grep /mnt/efs
```

### Step 6: Create and Verify a Test File

Create a test file inside the EFS mount directory:

```bash
echo "SkillPilote Day 18 - Amazon EFS integration successful" | sudo tee /mnt/efs/day18-test.txt
```

Read the file:

```bash
cat /mnt/efs/day18-test.txt
```

Verify the directory contents:

```bash
ls -l /mnt/efs/
```

**Expected result:** The test file is successfully created and read from the mounted EFS file system.

### Step 7: Create AWS Backup Vault

1. Open AWS Backup.
2. Navigate to Backup vaults.
3. Create a backup vault named `SkillPilote-Day18-EFS-Vault`.
4. Select the encryption configuration.
5. Verify successful vault creation.

### Step 8: Create AWS Backup Plan

1. Navigate to AWS Backup → Backup plans.
2. Create a backup plan named `SkillPilote-Day18-EFS-Plan`.
3. Configure the backup rule:
   - Rule name: Daily-EFS-Backup
   - Backup vault: SkillPilote-Day18-EFS-Vault
   - Schedule: Daily
   - Retention period: 7 days
4. Save the backup plan.

### Step 9: Add EFS Resource to Backup Selection

1. Open the created backup plan.
2. Add a resource assignment.
3. Set the selection name to `SkillPilote-Day18-EFS-Selection`.
4. Select the EFS file system as the protected resource.
5. Assign the AWS Backup service role.
6. Verify that the EFS resource is included in the backup selection.

### Step 10: Verify Backup Job

Execute the following AWS CLI command:

```powershell
aws backup list-backup-jobs `
  --by-resource-type EFS `
  --region ap-south-1 `
  --output table
```

Check the recovery points:

```powershell
aws backup list-recovery-points-by-backup-vault `
  --backup-vault-name SkillPilote-Day18-EFS-Vault `
  --region ap-south-1 `
  --output table
```

**Verification result:**

- Backup job completed successfully.
- Backup progress: 100%.
- Recovery point status: COMPLETED.
- Resource type: EFS.
- Recovery point encryption: Enabled.

## 5. Final Result

Amazon EFS was successfully created and integrated with the EC2 instance using NFS v4.1.

The test file was successfully written to and read from the mounted EFS directory. AWS Backup was configured with a backup vault, backup plan, and resource selection. A backup recovery point was successfully generated with COMPLETED status.

## 6. Screenshots

All implementation screenshots are available in the `screenshots` directory.

The screenshots cover:

1. EC2 instance configuration
2. Systems Manager connectivity
3. EFS security group configuration
4. EFS file system creation
5. EFS mount target configuration
6. EFS mounting and test file verification
7. Backup vault creation
8. Backup plan configuration
9. Backup IAM role and resource selection
10. Successful backup job and recovery point verification

## 7. Conclusion

The practical successfully demonstrated the integration of Amazon EFS with Amazon EC2 and the use of AWS Backup to protect an EFS file system. The mounted shared storage was verified through file creation and retrieval, and the backup recovery point was confirmed as COMPLETED.

**Status: Successfully Completed**