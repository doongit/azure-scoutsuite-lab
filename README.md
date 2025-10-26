# azure-scoutsuite-lab
Hands-on Azure Zero-Trust security assessment using ScoutSuite and Azure CLI. Includes methodology, key findings, and mapped remediations aligned with CIS & NIST 800-53.

## Repo Map
- `ScoutSuite/` - local copy of ScoutSuite and generated reports (kept out of Git via `.gitignore`).
- `scout-notes/azure-wgu-lab.md` - redacted findings summary with evidence references.
- `screenshots/` - redacted PNGs such as `azure-dashboard-redacted.png`, `azure-logging-alerts-redacted.png`, `azure-security-center-redacted.png`.
- `reports/` - local-only storage for redacted CSV exports (`Azure-Active-Directory-Applications-redacted.csv`, `RBAC-Roles-redacted.csv`) and raw HTML (do not commit unredacted data).
- `multi-cloud/` - AWS and GCP playbooks plus cross-cloud comparison.
- `terraform-iac-demo/` - secure storage landing zone IaC sample (now with `terraform.tfvars.example`).
- `ai-security-lab/` - RBAC + prompt-filtering LLM showcase.

## Screenshot Guidance
Add redacted evidence to `screenshots/` using descriptive names (example: `azure-rbac-redacted.png`). Reference them in notebooks or docs, but keep raw/full reports outside version control for privacy.

## Quickstart
1. Activate virtual environment inside `ScoutSuite/` and install dependencies.
2. Run `scout azure --cli --subscriptions <subscription-id>` or `python -m ScoutSuite azure ...`.
3. Review HTML report under `ScoutSuite/scoutsuite-report/` and capture redacted screenshots for documentation.
