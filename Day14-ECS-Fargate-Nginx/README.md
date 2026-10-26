# Day 14: Deploy Nginx Using AWS ECS Fargate

## Aim
To deploy an Nginx web server using Amazon ECS Fargate and access the Nginx welcome page through a public IP address.

## Services Used
- Amazon Elastic Container Service (Amazon ECS)
- AWS Fargate
- AWS Identity and Access Management (IAM)
- Amazon EC2 networking and security groups

## Procedure
1. Verified AWS CLI credentials and selected the Mumbai region (ap-south-1).
2. Created an ECS cluster named SkillPilote-Day14-Cluster.
3. Created the ECS task execution IAM role and attached the required policy.
4. Created and registered the Nginx task definition.
5. Identified a VPC and subnet for the Fargate service.
6. Configured a security group to allow HTTP traffic on port 80.
7. Created an ECS service with one Fargate task and public IP assignment.
8. Retrieved the task network interface and public IP address.
9. Opened the public IP in a browser to verify the Nginx welcome page.

## Expected Result
The default Nginx welcome page is accessible through the public IP address of the running Fargate task.

## Screenshots
Save practical screenshots in the screenshots folder:
- 01-ecs-cluster.png
- 02-task-definition.png
- 03-running-service.png
- 04-nginx-welcome-page.png

## Cleanup
After capturing the required evidence, delete the ECS service and other resources created exclusively for this practical to avoid unnecessary AWS charges.

## Conclusion
Amazon ECS Fargate can run containerized web applications without requiring users to manage EC2 container-host instances.
