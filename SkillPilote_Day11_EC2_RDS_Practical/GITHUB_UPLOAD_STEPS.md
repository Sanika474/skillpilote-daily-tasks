# GitHub upload steps (Windows PowerShell)

Repository: https://github.com/Sanika474/skillpilote-daily-tasks

1. Copy the `SkillPilote_Day11_EC2_RDS_Practical` folder into your local clone of the repository.
2. Open PowerShell in the repository root and run:

```powershell
git status
git add .\SkillPilote_Day11_EC2_RDS_Practical\
git diff --cached --stat
git commit -m "Day 11: EC2 to RDS practical report and evidence"
git push origin main
```

3. Verify the folder at https://github.com/Sanika474/skillpilote-daily-tasks

Security check: do not add AWS passwords, access keys, `.pem` private keys, or credential files. Review screenshots for sensitive details before pushing.
