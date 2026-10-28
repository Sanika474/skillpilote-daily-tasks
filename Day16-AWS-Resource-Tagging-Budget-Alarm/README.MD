**# Day 16: AWS Resource Tagging and Budget Alarm**



**## 1. Aim**

**To implement AWS resource tagging using Python and Boto3 and configure an AWS cost budget with an email alert at 80% of the budgeted amount.**



**## 2. Objectives**

**- Discover existing AWS resources.**

**- Apply the tag `Project=BeginnerRoadmap`.**

**- Automate resource tagging using Python and Boto3.**

**- Configure an AWS monthly cost budget.**

**- Set an email notification threshold at 80%.**

**- Maintain implementation code and evidence in GitHub.**



**## 3. Technologies Used**

**- Amazon Web Services (AWS)**

**- AWS Resource Groups Tagging API**

**- AWS Budgets**

**- AWS CloudFormation**

**- AWS CLI**

**- Python**

**- Boto3**

**- Git and GitHub**



**## 4. Resource Tagging Details**



**| Property | Value |**

**|---|---|**

**| Tag key | Project |**

**| Tag value | BeginnerRoadmap |**

**| AWS region checked | ap-south-1 (Mumbai) |**

**| Resources discovered | 6 |**

**| Script execution mode | Preview |**



**The initial preview discovered four networking resources and two RDS snapshots. The script displayed the proposed tags without modifying the resources.**



**## 5. Implementation Steps**



**### Step 1: Verify AWS Credentials**

**Run the following command to verify the configured AWS identity:**



**```powershell**

**aws sts get-caller-identity**

**```**



**### Step 2: Install Dependencies**

**Install the Python dependency:**



**```powershell**

**python -m pip install -r requirements.txt**

**```**



**### Step 3: Preview Resource Tags**

**Run the tagging script from the repository root:**



**```powershell**

**python ".\\Day16-AWS-Resource-Tagging-Budget-Alarm\\script\\tag\_resources.py" --regions ap-south-1**

**```**



**The script discovers resources and previews the proposed tag. It does not make changes unless the `--apply` flag is provided.**



**### Step 4: Apply Resource Tags**

**After reviewing the preview, apply the tag to discovered resources:**



**```powershell**

**python ".\\Day16-AWS-Resource-Tagging-Budget-Alarm\\script\\tag\_resources.py" --regions ap-south-1 --apply**

**```**



**### Step 5: Verify Tags**

**Run the preview command again and verify that the resources display as already tagged.**



**### Step 6: Configure an AWS Budget**

**1. Open AWS Billing and Cost Management.**

**2. Select Budgets.**

**3. Create a monthly cost budget.**

**4. Set the desired budget amount.**

**5. Configure an actual-cost alert at 80%.**

**6. Enter an email address for notifications.**

**7. Save the budget and verify its configuration.**



**### Step 7: Validate the CloudFormation Template**

**Validate the template without creating resources:**



**```powershell**

**aws cloudformation validate-template --template-body file://Day16-AWS-Resource-Tagging-Budget-Alarm/cloudformation/budget.yaml --region us-east-1**

**```**



**Template validation does not deploy the budget.**



**## 6. Budget Configuration**



**| Setting | Value |**

**|---|---|**

**| Budget name | SkillPilote-Day16-Budget |**

**| Budget period | Monthly |**

**| Example budget amount | USD 5 |**

**| Notification threshold | 80% |**

**| Notification type | Actual cost |**

**| Notification method | Email |**



**The amount above is an example. Confirm the actual amount configured in the AWS Console before reporting the final result.**



**## 7. Safety Considerations**

**- The Python script runs in preview mode by default.**

**- Only apply tags after reviewing the resources.**

**- Do not store AWS credentials or secret keys in the repository.**

**- Budget alerts notify the user but do not automatically stop services.**

**- AWS billing information and alerts may be delayed.**

**- Review existing RDS snapshots and networking resources before deleting them.**

**- Check AWS pricing and account-specific usage limits before creating additional budgets.**



**## 8. Project Structure**



**```text**

**Day16-AWS-Resource-Tagging-Budget-Alarm/**

**├── README.md**

**├── requirements.txt**

**├── script/**

**│   └── tag\_resources.py**

**├── cloudformation/**

**│   └── budget.yaml**

**└── screenshots/**

&#x20;   **└── README.md**

**```**



**## 9. Evidence and Screenshots**

**Save the following screenshots in the `screenshots` directory:**



**1. Resource tagging preview or verification.**

**2. AWS budget configuration showing the 80% alert.**

**3. AWS Budgets dashboard showing the created budget.**



**Do not include credentials or sensitive account information in screenshots.**



**## 10. Result**

**A Python-based AWS resource-tagging workflow and a CloudFormation budget template have been prepared. The tagging script successfully discovered six resources in the Mumbai region during preview. The final tagging result and budget configuration must be verified in AWS before claiming successful completion.**



