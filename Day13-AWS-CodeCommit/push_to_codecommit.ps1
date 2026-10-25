# SkillPilote Day 13 - AWS CodeCommit automation
$ErrorActionPreference = "Stop"

$RepositoryName = "skillpilote-day13"
$Region = "ap-south-1"
$Branch = "master"
$RepositoryUrl = "https://git-codecommit.$Region.amazonaws.com/v1/repos/$RepositoryName"

Write-Host "Checking AWS identity..."
aws sts get-caller-identity --output table
if ($LASTEXITCODE -ne 0) { throw "AWS authentication failed." }

Write-Host "Checking CodeCommit repository..."
aws codecommit get-repository --repository-name $RepositoryName --region $Region 2>$null | Out-Null

if ($LASTEXITCODE -ne 0) {
    Write-Host "Creating repository: $RepositoryName"
    aws codecommit create-repository --repository-name $RepositoryName --repository-description "SkillPilote Day 13 README practical" --region $Region
    if ($LASTEXITCODE -ne 0) { throw "Repository creation failed." }
} else {
    Write-Host "Repository already exists; reusing it."
}

$WorkDir = Join-Path $PSScriptRoot "work"
New-Item -ItemType Directory -Path $WorkDir -Force | Out-Null
Set-Location $WorkDir

if (-not (Test-Path ".git")) {
    git init -b $Branch
    if ($LASTEXITCODE -ne 0) { throw "Git initialization failed." }
}

@"
# SkillPilote Day 13 - AWS CodeCommit

This practical demonstrates creating and managing an AWS CodeCommit
repository using AWS CLI, Git, and PowerShell.

## Objectives
- Create or reuse an AWS CodeCommit repository.
- Initialize a local Git repository.
- Add and commit a README file.
- Configure the CodeCommit remote.
- Push the commit and verify it in AWS Console.

## Security
Configure AWS CLI credentials using an approved IAM identity with the
required CodeCommit permissions. Never store access keys in this file.
"@ | Set-Content -Path "README.md" -Encoding utf8

git add README.md
if ($LASTEXITCODE -ne 0) { throw "Git add failed." }

git rev-parse --verify HEAD 2>$null | Out-Null
if ($LASTEXITCODE -ne 0) {
    git commit -m "Add Day 13 README"
} else {
    git diff --cached --quiet
    if ($LASTEXITCODE -ne 0) { git commit -m "Update Day 13 README" }
}
if ($LASTEXITCODE -ne 0) { throw "Git commit failed." }

$ExistingRemote = git remote get-url origin 2>$null
if ($LASTEXITCODE -eq 0) {
    if ($ExistingRemote -ne $RepositoryUrl) {
        throw "Origin points to a different URL: $ExistingRemote"
    }
} else {
    git remote add origin $RepositoryUrl
    if ($LASTEXITCODE -ne 0) { throw "Adding origin failed." }
}

git push -u origin $Branch
if ($LASTEXITCODE -ne 0) { throw "Push failed. Check Git HTTPS authentication and permissions." }

Write-Host "Success: README committed and pushed to CodeCommit."
Write-Host "Repository: $RepositoryUrl"
Write-Host "Branch: $Branch"
