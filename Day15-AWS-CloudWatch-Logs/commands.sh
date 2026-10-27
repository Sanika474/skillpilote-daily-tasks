#!/bin/bash

# Install CloudWatch Agent (Amazon Linux)
sudo yum install amazon-cloudwatch-agent -y

# Create a test log file
sudo touch /home/ec2-user/test.log
sudo chmod 666 /home/ec2-user/test.log

# Generate a sample log entry
echo "Day 15 SkillPilote: CloudWatch test log successful" \
  | sudo tee -a /home/ec2-user/test.log

# Start the CloudWatch Agent using the configuration file
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config -m ec2 \
  -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json -s

# Generate another log entry for verification
echo "Day 15: Log received in CloudWatch verification test" \
  | sudo tee -a /home/ec2-user/test.log

# Check agent status
sudo systemctl status amazon-cloudwatch-agent