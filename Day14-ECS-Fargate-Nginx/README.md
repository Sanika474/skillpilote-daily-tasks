# Day 14: Deploy Nginx with Amazon ECS Fargate

## Aim
Deploy the Nginx container on Amazon ECS using AWS Fargate and access the welcome page over HTTP.

## Architecture
- Amazon ECS cluster
- AWS Fargate service with one task
- Official `nginx:latest` container image
- Task execution IAM role
- Security group allowing inbound TCP port 80
- Existing VPC and public subnet(s)
- CloudWatch Logs with 7-day retention
- Public IP assignment enabled for the task

## Prerequisites
1. AWS CLI installed and configured.
2. IAM permissions to create CloudFormation stacks, ECS resources, IAM roles, security groups, and CloudWatch log groups.
3. An existing VPC and one or more **public subnets** in that VPC.
4. Each selected public subnet must have an active `0.0.0.0/0` route to an Internet Gateway. `MapPublicIpOnLaunch=True` alone does not prove a subnet is public.

For the SkillPilote practice account, the region used was `ap-south-1` (Mumbai). Change it if your instructor requires another region.

## Files
- `cloudformation.yaml` — infrastructure-as-code template.
- `deploy.ps1` — validates and deploys the CloudFormation stack.
- `cleanup.ps1` — asks for confirmation and deletes the stack.
- `screenshots/` — add screenshots of the created stack, ECS service/task, and Nginx welcome page.

## 1. Verify AWS credentials
Open PowerShell in this folder:

```powershell
aws --version
aws sts get-caller-identity --region ap-south-1
```

## 2. Identify a VPC and public subnet
List VPCs:

```powershell
aws ec2 describe-vpcs --region ap-south-1 --query "Vpcs[].{VpcId:VpcId,Default:IsDefault,CIDR:CidrBlock}" --output table
```

List subnets for the selected VPC (replace the VPC ID):

```powershell
$VpcId = "vpc-REPLACE_WITH_YOUR_VPC_ID"
aws ec2 describe-subnets --region ap-south-1 --filters "Name=vpc-id,Values=$VpcId" --query "Subnets[].{SubnetId:SubnetId,AZ:AvailabilityZone,AutoPublicIP:MapPublicIpOnLaunch}" --output table
```

Check the explicitly associated route table for a subnet:

```powershell
$SubnetId = "subnet-REPLACE_WITH_PUBLIC_SUBNET_ID"
aws ec2 describe-route-tables --region ap-south-1 --filters "Name=association.subnet-id,Values=$SubnetId" --query "RouteTables[].Routes[].{Destination:DestinationCidrBlock,Target:GatewayId,State:State}" --output table
```

If no route table is returned, check the VPC main route table:

```powershell
aws ec2 describe-route-tables --region ap-south-1 --filters "Name=vpc-id,Values=$VpcId" "Name=association.main,Values=true" --query "RouteTables[].Routes[].{Destination:DestinationCidrBlock,Target:GatewayId,State:State}" --output table
```

Choose only subnet IDs whose effective route table has an active `0.0.0.0/0` route to an `igw-...` Internet Gateway.

## 3. Validate the template
```powershell
aws cloudformation validate-template --template-body file://cloudformation.yaml --region ap-south-1
```

## 4. Deploy
Use the actual VPC ID and comma-separated public subnet IDs. For example, replace the sample IDs below with the values from your account:

```powershell
.\deploy.ps1 -VpcId "vpc-REPLACE_WITH_YOUR_VPC_ID" -SubnetIds "subnet-REPLACE_WITH_PUBLIC_SUBNET_ID" -Region "ap-south-1"
```

If PowerShell blocks local scripts, run this only for the current PowerShell process, then retry:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

The deployment script uses CloudFormation and requests `CAPABILITY_NAMED_IAM` because the template creates a named IAM role.

## 5. Verify the service
Check stack outputs:

```powershell
aws cloudformation describe-stacks --stack-name skillpilote-day14-nginx --region ap-south-1 --query "Stacks[0].Outputs" --output table
```

Check ECS service:

```powershell
aws ecs describe-services --cluster SkillPilote-Day14-Nginx-Cluster --services SkillPilote-Day14-Nginx-Service --region ap-south-1 --query "services[0].{Status:status,Desired:desiredCount,Running:runningCount,Events:events[0].message}" --output table
```

Find the task:

```powershell
$TaskArn = aws ecs list-tasks --cluster SkillPilote-Day14-Nginx-Cluster --service-name SkillPilote-Day14-Nginx-Service --region ap-south-1 --query "taskArns[0]" --output text
aws ecs describe-tasks --cluster SkillPilote-Day14-Nginx-Cluster --tasks $TaskArn --region ap-south-1 --query "tasks[0].{Status:lastStatus,Attachments:attachments[0].details}" --output json
```

Find the task network interface ID in the output and retrieve its public IP:

```powershell
$ENI = "eni-REPLACE_WITH_NETWORK_INTERFACE_ID"
$PublicIP = aws ec2 describe-network-interfaces --network-interface-ids $ENI --region ap-south-1 --query "NetworkInterfaces[0].Association.PublicIp" --output text
$PublicIP
Start-Process "http://$PublicIP"
```

Expected result: the browser displays the default **Welcome to nginx!** page.

## Troubleshooting
- **Service has no running task:** inspect ECS service events and task stopped reason.
- **Browser does not connect:** verify task status is `RUNNING`, the task has a public IP, security group inbound TCP 80 is allowed, and the subnet's effective route table has an active route to an Internet Gateway.
- **No public IP:** inspect the task's network interface and service `AssignPublicIp` configuration.
- **CloudFormation deployment fails:** inspect CloudFormation stack Events for the first failed resource.
- **Insufficient permissions:** ensure the caller can create CloudFormation stacks and the resources in the template.

## 6. Cleanup (important)
Fargate tasks may incur charges while running. After taking screenshots, remove the resources created by this stack:

```powershell
.\cleanup.ps1 -Region "ap-south-1" -StackName "skillpilote-day14-nginx"
```

Type `DELETE` when prompted. Wait for stack deletion to complete:

```powershell
aws cloudformation wait stack-delete-complete --stack-name skillpilote-day14-nginx --region ap-south-1
```

Only the resources managed by this CloudFormation stack are deleted. Do not manually delete pre-existing VPCs or subnets.

## Result
The template and deployment script provide a repeatable way to deploy Nginx on ECS Fargate. Record the actual result and add screenshots after testing the deployment in your AWS account.
