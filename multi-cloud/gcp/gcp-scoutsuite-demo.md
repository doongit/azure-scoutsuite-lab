# GCP ScoutSuite Demo

## Goal
Scan a GCP project using a **service account JSON key** with viewer-style access.

## Enable Required APIs (in your GCP project)
- Cloud Resource Manager API
- Compute Engine API
- Identity and Access Management (IAM) API
- Security Command Center API (optional, free tier has limits)

## Service Account (least privilege)
Create a service account and grant:
- `Viewer` (project level)
- `Security Reviewer` (optional, if available)
Download the JSON key: `gcp-audit-sa.json` (store **outside the repo**).

## Run ScoutSuite
```bash
scout gcp --service-account-file "C:\path\to\gcp-audit-sa.json" \
  --project <YOUR_PROJECT_ID> \
  --report-dir ".\reports\gcp\2025-10-24" \
  --report-name "gcp-scout"
```

If needed:

```bash
python -m scoutsuite.cli gcp --service-account-file ... --project <ID>
```

## Open the Report

`scoutsuite-report\index.html` (or the custom folder)

## Document Top Findings

| Category      | Severity | Finding                      | Risk                 | Fix                                                |
| ------------- | -------- | ---------------------------- | -------------------- | -------------------------------------------------- |
| IAM           | High     | Broad `Owner` at project     | Full compromise risk | Replace with granular roles                        |
| Storage (GCS) | High     | Public bucket                | Data exposure        | Remove `allUsers`/`allAuthenticatedUsers` bindings |
| Logging       | Medium   | Audit Logs not fully enabled | Low visibility       | Enable Admin/Data Access audit logs                |

## Notes

Free-tier/SCC features may be limited; still useful for IAM/storage posture.
