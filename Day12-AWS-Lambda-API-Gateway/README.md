# SkillPilote Day 12: AWS Lambda with API Gateway

## Aim
Expose an AWS Lambda function through Amazon API Gateway and test
the greeting response in a web browser.

## Technology
- AWS Lambda
- Amazon API Gateway HTTP API
- Node.js 22
- AWS IAM
- Amazon CloudWatch
- AWS CLI
- PowerShell

## Architecture

Browser
  -> API Gateway HTTP API
  -> GET /greeting
  -> Lambda function: skillpilote-day12-greeting
  -> JSON response

## AWS Configuration

Region: ap-south-1
Lambda function: skillpilote-day12-greeting
Runtime: nodejs22.x
Handler: index.handler
API route: GET /greeting
Stage: $default

## API Endpoint

https://pp6es96c1g.execute-api.ap-south-1.amazonaws.com/greeting

## Expected Response

{
  "message": "Hello from SkillPilote Day 12!",
  "service": "AWS Lambda",
  "region": "ap-south-1",
  "path": "/greeting",
  "method": "GET"
}

## Implementation Files

- index.mjs: Lambda handler source code
- function.zip: Lambda deployment package
- trust-policy.json: Lambda execution-role trust policy
- tests/test-event.json: Sample HTTP API test event
- evidence/: Practical screenshots

## Verification

1. Checked the AWS CLI region.
2. Created an IAM execution role with basic logging permissions.
3. Deployed the Lambda function.
4. Invoked Lambda directly and verified status code 200.
5. Created an API Gateway HTTP API.
6. Integrated the GET /greeting route with Lambda.
7. Deployed the default stage.
8. Opened the API endpoint in a browser and verified the JSON response.

## Security Notes

No AWS access keys or secret credentials are included in this project.
The Lambda role uses the basic execution policy for CloudWatch logging.

## Result

The Lambda function was successfully exposed through API Gateway.
The browser returned the expected greeting JSON response.
