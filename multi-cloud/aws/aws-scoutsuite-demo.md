# AWS ScoutSuite Demo

## Goal
Run ScoutSuite on an AWS account (free tier is fine) with **least-privilege read** and document key findings.

## Minimal IAM Permissions
Attach **AWS managed** policies to the user/role you’ll scan with:
- `ReadOnlyAccess`
- `SecurityAudit`

> Tip: Use a *role* with MFA if possible.

## Configure CLI
```bash
aws configure
# AWS Access Key ID: AKIA...
# AWS Secret Access Key: ...
# Default region name: us-east-1 (or your choice)
# Default output format: json
```

## Run ScoutSuite (Windows uses 'scout')

```bash
scout aws --profile default
# or name it:
# scout aws --profile myaudit --report-dir ".\reports\aws\2025-10-24" --report-name "aws-scout"
```

If PATH is odd:

```bash
python -m scoutsuite.cli aws --profile default
```

## Open the Report

`scoutsuite-report\index.html` (or your custom report dir)

## Document Top Findings

| Category               | Severity | Finding                       | Risk                 | Fix                                          |
| ---------------------- | -------- | ----------------------------- | -------------------- | -------------------------------------------- |
| IAM                    | High     | Wildcard `*` in inline policy | Privilege escalation | Replace with least-privilege actions         |
| S3                     | High     | Bucket public ACL/Policy      | Data exposure        | Block Public Access + bucket policy restrict |
| CloudTrail             | Medium   | Trail not multi-region        | Incomplete auditing  | Enable multi-region + S3 SSE                 |
| Security Hub/GuardDuty | Medium   | Disabled                      | Missed detections    | Enable in home region                        |

## Evidence (local only)

* `reports/aws/2025-10-24/` (gitignored)
* Redacted screenshots in `screenshots/`

## Lessons Learned

* IAM least privilege & org-wide blockers are the fastest wins.
* GuardDuty + SecurityHub add strong baseline visibility.
