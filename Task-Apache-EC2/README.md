**# Practical: Host an HTML Page Using Apache on AWS EC2**



**## Aim**

**To host a public HTML webpage on an Apache web server running on an AWS EC2 instance.**



**## Requirements**

**- AWS account**

**- Amazon EC2 instance running Amazon Linux**

**- Windows PowerShell**

**- SSH private key (`.pem` file)**

**- Git and GitHub account**



**## Procedure**



**### Step 1: Launch or select an EC2 instance**

**Open the AWS Management Console and navigate to EC2. Use an existing suitable instance or launch a new Amazon Linux instance.**



**### Step 2: Configure security**

**Configure the EC2 security group to allow:**

**- SSH (TCP port 22) from your own IP address**

**- HTTP (TCP port 80) from `0.0.0.0/0` for a publicly accessible webpage**



**### Step 3: Connect to EC2**

**Use SSH from PowerShell with the instance's public IP address and the correct private key.**



**### Step 4: Install and start Apache**

**For Amazon Linux 2023, execute:**



**```bash**

**sudo dnf install -y httpd**

**sudo systemctl enable --now httpd**

**```**



**### Step 5: Transfer the HTML file**

**From Windows PowerShell, use SCP to copy `index.html` to the EC2 instance's web directory.**



**### Step 6: Verify the webpage**

**Open `http://YOUR\_PUBLIC\_IP` in a browser and verify that the HTML page is displayed.**



**## Expected Result**

**The HTML webpage is accessible through the public IP address of the EC2 instance.**



**## Security Note**

**Never upload private keys, AWS access keys, passwords, or other sensitive credentials to GitHub.**





