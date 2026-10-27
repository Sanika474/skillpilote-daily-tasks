# Day 15: AWS CloudWatch Logs from EC2

## Aim
To generate a sample log entry from an EC2 instance and verify that it appears in the Amazon CloudWatch console.

## Services Used
- Amazon EC2
- Amazon CloudWatch Logs
- Amazon CloudWatch Agent
- AWS IAM

## Practical Steps
1. Connect to the running EC2 Linux instance.
2. Install the Amazon CloudWatch Agent.
3. Create a test log file and write a sample message using `echo`.
4. Attach an IAM role with the required CloudWatch permissions.
5. Configure the agent to monitor the test log file.
6. Start or restart the CloudWatch Agent.
7. Generate a new log entry.
8. Open CloudWatch Logs and verify the message.

## Log Group
`/skillpilote/day15`

## Sample Log Message
`Day 15: Log received in CloudWatch verification test`

## Expected Result
The sample log generated on the EC2 instance appears successfully in the Amazon CloudWatch Logs console.

## Screenshots
Add the practical screenshots to the `screenshots` folder after completing each step.