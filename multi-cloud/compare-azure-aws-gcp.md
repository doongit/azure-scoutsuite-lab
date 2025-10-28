# Azure vs AWS vs GCP — ScoutSuite Comparison

## Scope
- **Azure**: WGU Student Subscription (CLI auth)
- **AWS**: Free-tier account (ReadOnlyAccess + SecurityAudit)
- **GCP**: Free-tier project (Viewer + Security Reviewer)

## High-Level Findings (Example)
| Domain | Azure | AWS | GCP | Notes |
|---|---:|---:|---:|---|
| Identity (IAM/AAD) | 2 High | 3 High | 2 High | Ownership scope, legacy auth, wildcard policies |
| Storage | 1 Medium | 2 High | 1 High | Public access defaults differ (S3/GCS vs Azure Storage) |
| Logging/Monitoring | 1 Medium | 1 Medium | 1 Medium | Enable Activity Log/CloudTrail/Audit Logs |
| Security Services | Limited (student) | GuardDuty off | SCC partial | Baselines vary by tier/region |

## Control Mapping (CIS/NIST 800-53)
- **AC-2 / AC-6** (Account/Least Privilege): IAM + RBAC clean-up across clouds
- **AU-2 / AU-12** (Logging): CloudTrail / Azure Activity / GCP Audit Logs
- **SC-7** (Boundary Protection): Private endpoints/VPC endpoints
- **SC-13** (Cryptographic Protection): SSE/SSE-KMS/CMK + HTTPS-only

## Remediation Highlights
- Remove wildcard IAM, reduce subscription/project Owner, enforce MFA.
- Block public access on S3/GCS/Azure Storage, require HTTPS only.
- Turn on GuardDuty/SecurityHub (AWS), Defender plans/Provider registration (Azure), SCC (GCP).
- Centralize logs to SIEM (Sentinel/Splunk/Cloud Logging exports).

## Lessons Learned
- Identity sprawl & public storage are the most common multi-cloud risks.
- “Provider registration / service enablement” gates a lot of findings.
- Baseline CSPM + SIEM + IaC guardrails = fastest risk reduction.
