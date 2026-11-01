**# Day 20 – AWS Lambda, DynamoDB and API Gateway**



**## Objective**

**To build a serverless visitor registration application using AWS Lambda, Amazon DynamoDB and Amazon API Gateway.**



**## Technologies Used**

**- AWS Lambda**

**- Node.js 24.x**

**- Amazon DynamoDB**

**- Amazon API Gateway (HTTP API)**

**- AWS IAM**

**- Amazon CloudWatch**

**- AWS CLI**

**- PowerShell**



**## Architecture**

**Client → API Gateway → AWS Lambda → Amazon DynamoDB**



**## Implementation Steps**

**1. Configured AWS CLI and verified AWS account access.**

**2. Created DynamoDB table `SkillPilote-Day20-Visitors`.**

**3. Created Lambda execution IAM role with CloudWatch and DynamoDB permissions.**

**4. Developed a Node.js Lambda function using AWS SDK v3.**

**5. Configured the DynamoDB table name as a Lambda environment variable.**

**6. Created an API Gateway HTTP API.**

**7. Configured the `POST /visitors` route and Lambda integration.**

**8. Granted API Gateway permission to invoke Lambda.**

**9. Tested the API using PowerShell.**

**10. Verified visitor records in DynamoDB and execution logs in CloudWatch.**



**## Sample Request**



**```json**

**{**

&#x20; **"name": "Rahul",**

&#x20; **"email": "rahul@example.com"**

**}**

**```**



**## Expected Successful Response**



**```json**

**{**

&#x20; **"message": "Visitor recorded successfully",**

&#x20; **"visitorId": "generated-unique-id"**

**}**

**```**



**## Validation**

**- Valid visitor data returns HTTP 201.**

**- Missing or invalid visitor information returns HTTP 400.**

**- Visitor records are stored in DynamoDB.**

**- Lambda execution logs are available in CloudWatch.**



**## Project Structure**



**```text**

**Day20-AWS-Lambda-DynamoDB-API-Gateway/**

**├── README.md**

**├── lambda/**

**│   ├── index.mjs**

**│   ├── package.json**

**│   └── package-lock.json**

**└── screenshots/**

**```**



**## Learning Outcomes**

**- Understanding serverless architecture.**

**- Creating and deploying AWS Lambda functions.**

**- Integrating Lambda with DynamoDB.**

**- Creating HTTP APIs using API Gateway.**

**- Configuring IAM execution permissions.**

**- Monitoring Lambda executions using CloudWatch.**



**## Practical Status**

**Completed and tested successfully.**



