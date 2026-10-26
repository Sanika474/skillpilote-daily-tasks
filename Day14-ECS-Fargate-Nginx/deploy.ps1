param(
    [Parameter(Mandatory = $true)]
    [string]$VpcId,

    [Parameter(Mandatory = $true)]
    [string]$SubnetIds,

    [string]$Region = "ap-south-1",
    [string]$StackName = "skillpilote-day14-nginx"
)

$ErrorActionPreference = "Stop"

Write-Host "Checking AWS identity..."
aws sts get-caller-identity --region $Region
if ($LASTEXITCODE -ne 0) { throw "AWS credentials check failed. Run aws configure or sign in first." }

Write-Host "Validating CloudFormation template..."
aws cloudformation validate-template `
  --template-body file://cloudformation.yaml `
  --region $Region
if ($LASTEXITCODE -ne 0) { throw "Template validation failed." }

Write-Host "Deploying stack $StackName in $Region..."
aws cloudformation deploy `
  --template-file cloudformation.yaml `
  --stack-name $StackName `
  --parameter-overrides "ProjectName=SkillPilote-Day14-Nginx" "VpcId=$VpcId" "SubnetIds=$SubnetIds" `
  --capabilities CAPABILITY_NAMED_IAM `
  --region $Region
if ($LASTEXITCODE -ne 0) { throw "CloudFormation deployment failed. Check the stack Events in AWS Console." }

Write-Host "Deployment finished. Stack outputs:"
aws cloudformation describe-stacks `
  --stack-name $StackName `
  --region $Region `
  --query "Stacks[0].Outputs" `
  --output table
