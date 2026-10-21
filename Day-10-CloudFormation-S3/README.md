# Day 10 — AWS CloudFormation S3 Bucket

## Aim
Deploy a JSON template through the AWS CloudFormation console and verify that an Amazon S3 bucket is created.

## AWS configuration
- AWS Region: Asia Pacific (Mumbai), `ap-south-1`
- CloudFormation stack: `skillpilote-day10-s3-stack`
- Resource type: `AWS::S3::Bucket`

## Files
- `s3-bucket-template.json` — CloudFormation template used to create the bucket.
- `cloud_formation_report.docx` — Practical report with labelled evidence screenshots.
- `evidence/` — Screenshot evidence from the practical.

## Procedure
1. Open CloudFormation and choose **Create stack → With new resources (standard)**.
2. Upload `s3-bucket-template.json`.
3. Enter the stack name `skillpilote-day10-s3-stack`.
4. Review the stack configuration and submit it.
5. Wait for the stack status to become `CREATE_COMPLETE`.
6. Check the Resources and Outputs tabs.
7. Open Amazon S3 in the same region and confirm the bucket exists.

## Result
The supplied evidence shows the CloudFormation stack `skillpilote-day10-s3-stack` in `CREATE_COMPLETE` status, one `AWS::S3::Bucket` resource in `CREATE_COMPLETE` status, the stack outputs, and the bucket in the S3 console.

## Security notes
- The template blocks public access to the created bucket.
- No AWS credentials, access keys, passwords, or MFA codes are included in this repository.
- Do not enable public access for this practical.
- Review AWS charges and delete the stack after evaluation if it is no longer required. Ensure the bucket is empty before deleting the stack.

## Evidence
See the labelled screenshots in the `evidence/` folder and the practical report.
