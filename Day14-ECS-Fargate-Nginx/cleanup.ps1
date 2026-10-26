param(
    [string]$Region = "ap-south-1",
    [string]$StackName = "skillpilote-day14-nginx"
)

$ErrorActionPreference = "Stop"

Write-Host "This will delete the CloudFormation stack and its resources: $StackName"
$confirmation = Read-Host "Type DELETE to continue"
if ($confirmation -ne "DELETE") {
    Write-Host "Cancelled. No resources were deleted."
    exit 0
}

aws cloudformation delete-stack --stack-name $StackName --region $Region
if ($LASTEXITCODE -ne 0) { throw "Could not start stack deletion. Check the stack name and region." }

Write-Host "Deletion started. Wait for completion with:"
Write-Host "aws cloudformation wait stack-delete-complete --stack-name $StackName --region $Region"
