@'
# Day 19 - AWS Application Load Balancer

## Objective
To configure an AWS Application Load Balancer (ALB) that distributes incoming HTTP traffic across two EC2 web servers.

## AWS Services Used
- Amazon EC2
- Application Load Balancer
- Target Groups
- Security Groups
- Amazon Linux 2023

## Architecture
Internet
   |
Application Load Balancer (HTTP : 80)
   |
Target Group (HTTP : 80)
   |
   |-----------------------|
   |                       |
Web Server 1           Web Server 2
(ap-south-1a)           (ap-south-1b)

## Implementation Steps
1. Verified the AWS CLI configuration and selected the ap-south-1 region.
2. Identified the VPC, public subnets, route table and Amazon Linux AMI.
3. Created an ALB security group allowing HTTP traffic on port 80.
4. Created an EC2 security group allowing HTTP traffic only from the ALB.
5. Launched two EC2 instances in separate Availability Zones.
6. Installed and configured Apache using EC2 User Data.
7. Created an ALB target group with HTTP health checks.
8. Registered both EC2 instances with the target group.
9. Created an internet-facing Application Load Balancer.
10. Configured an HTTP listener on port 80.
11. Verified that both registered targets became healthy.
12. Tested the ALB DNS endpoint and traffic distribution.

## Configuration
- Region: ap-south-1
- Load Balancer: SkillPilote-Day19-ALB
- Target Group: SkillPilote-Day19-TG
- Listener: HTTP port 80
- Health Check Path: /
- Target Type: Instance
- Web Server 1: Amazon Linux 2023
- Web Server 2: Amazon Linux 2023
- Availability Zones: ap-south-1a and ap-south-1b

## Result
Successfully configured an internet-facing Application Load Balancer and connected two EC2 web servers. Both targets became healthy, and HTTP requests through the ALB were tested to verify server responses.

## Screenshots
See the screenshots folder for EC2 instances, ALB configuration, target health, listener rules and browser testing evidence.

## Learning Outcomes
- Understood Application Load Balancer architecture.
- Learned how to create and configure target groups.
- Configured listener rules to forward HTTP traffic.
- Implemented EC2 health checks.
- Understood traffic distribution across multiple Availability Zones.
- Practiced AWS CLI-based resource management.

## Cleanup
AWS resources should be deleted after completing the practical to avoid unnecessary charges.
'@ | Set-Content -Path ".\Day19-AWS-Application-Load-Balancer\README.md" -Encoding UTF8