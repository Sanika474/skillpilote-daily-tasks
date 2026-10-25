# SkillPilote Day 13 - AWS CodeCommit

This practical demonstrates creating and managing an AWS CodeCommit
repository using AWS CLI, Git, and PowerShell.

## Objectives
- Create or reuse an AWS CodeCommit repository.
- Initialize a local Git repository.
- Add and commit a README file.
- Configure the CodeCommit remote.
- Push the commit and verify it in AWS Console.

## AWS Configuration
- Region: ap-south-1 (Mumbai)
- Repository: skillpilote-day13
- Branch: master

## Security
Configure AWS CLI credentials using an approved IAM identity with
the required CodeCommit permissions. Never store access keys in this
script or commit credentials to source control.

## Execution
Run the script from PowerShell after configuring AWS CLI and Git
HTTPS authentication for CodeCommit.

## Verification
Confirm that README.md appears in the master branch of the repository
in the AWS CodeCommit console.
