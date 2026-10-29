# Day 17 – AWS Cognito User Pool with S3-Hosted Login Page

## Objective
To integrate Amazon Cognito User Pools with an HTML and JavaScript login page, implement user registration and authentication, and host the static website using Amazon S3.

## AWS Services and Technologies
- Amazon Cognito User Pools
- Amazon S3 Static Website Hosting
- AWS CLI
- HTML, CSS and JavaScript
- AWS Amplify JavaScript v6
- Windows PowerShell

## Implementation Steps
1. Created an Amazon Cognito User Pool in the `ap-south-1` region.
2. Created a public app client without a client secret for browser-based authentication.
3. Configured the User Pool ID and App Client ID in `index.html`.
4. Implemented user registration, email confirmation, sign-in, and sign-out using AWS Amplify.
5. Tested the login page locally using `python -m http.server 8000`.
6. Created an S3 bucket in the Mumbai region.
7. Uploaded `index.html` to the S3 bucket.
8. Enabled S3 static website hosting and configured the website's index document.
9. Configured bucket permissions for the classroom website demonstration.
10. Opened the S3 website endpoint and verified that the login page loaded.

## Test Results
- Local login page loaded successfully.
- Cognito user registration and email confirmation were tested.
- Sign-in and sign-out were tested on the custom page.
- The S3 website endpoint loaded successfully.

## Screenshots
Implementation evidence is stored in the `screenshots/` directory.

## Security Notes
- No Cognito client secret or AWS access keys are stored in the browser code.
- The public S3 website configuration is intended only for this non-sensitive classroom demonstration.
- Public website access should be reviewed and removed when the demonstration is no longer required.
- Production deployments should use HTTPS and a secure hosting configuration, such as CloudFront with a private S3 origin.

## Region
Asia Pacific (Mumbai) – `ap-south-1`

## Conclusion
Successfully implemented and tested a Cognito-integrated static login page and hosted it using Amazon S3 static website hosting.