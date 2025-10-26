# Azure WGU Lab — ScoutSuite Findings

## Scan Summary
- **Tool:** ScoutSuite 5.14.0 (local CLI run)
- **Subscription:** Azure for Students — ID `47180d00-d49b-4d40-9d0c-e830e30d609d`
- **Date:** 2025-10-24
- **Evidence bundle:** Redacted HTML report, screenshots, and CSV exports (kept outside Git)

## Highlights by Service

Dashboard snapshot (`azure-dashboard-redacted.png`) shows 381 Azure AD resources evaluated, 803 RBAC entries, and 100 total findings across identity/monitoring/storage.

### Identity & RBAC
- `Guest Users In Use` flagged in Azure AD; review invitation process and least-privilege MFA.
- `Users Can Create Security Group` currently allowed; confirm governance controls.
- RBAC custom role gap: `No Administering Resource Locks Role` detected. Add a scoped custom role to prevent accidental unlocks.
- CSV exports captured:
  - `reports/Azure-Active-Directory-Applications-redacted.csv` — inventory of enterprise apps and credentials.
  - `reports/RBAC-Roles-redacted.csv` — built-in and custom role definitions with assignment counts.

### Logging & Monitoring
- Azure Monitor diagnostic settings missing for subscription (no logs shipped).
- Activity log alerts absent for critical events (policy assignment, NSG CRUD, SQL firewall, Security Center alerts). Enable alerts and route to SOC mailbox/SIEM.
- Screenshots retained: `azure-logging-alerts-redacted.png`.

### Security Center
- No security contact set, Defender for Cloud plans disabled, and automated provisioning off. Enable Defender plans, set incident contacts, and configure email alerts. Evidence: `azure-security-center-redacted.png`.

### Storage
- Access keys not rotated, blob containers allow public access, HTTPS not enforced for custom domains, and trusted Microsoft services should be reviewed. Evidence: `azure-storage-accounts-redacted.png`.

### Networking
- `Network Watchers Not Enabled` detected. Deploy per-region Network Watcher for diagnostics (`azure-network-watchers-redacted.png`).

### Databases
- PostgreSQL and SQL dashboards highlight missing auditing, encryption, vulnerability assessments, and retention policies. Harden managed databases or disable unused services (`azure-postgresql-redacted.png`, `azure-sql-database-redacted.png`).

### App Services & Compute
- App Services baseline checks show authentication, client certificates, FTPS only, TLS 1.2, and modern runtimes should be enforced when apps are deployed (`azure-app-services-redacted.png`). VM checks currently pass (no resources flagged).

## Remediation Priorities
1. Enable activity log alerts and diagnostic settings; stream to Log Analytics.
2. Tighten RBAC by adding a Resource Lock Administrator role and reviewing guest users.
3. Harden storage account access (HTTPS-only, firewall rules, key rotation).
4. Turn on Defender for Cloud plans and security contacts for incident response.
5. Apply database and app service configuration baselines when workloads are provisioned.

## Evidence References (Redacted)
- `screenshots/azure-dashboard-redacted.png` — ScoutSuite summary dashboard.
- `screenshots/azure-logging-alerts-redacted.png` — Missing activity log alerts view.
- `screenshots/azure-security-center-redacted.png` — Defender for Cloud findings.
- `screenshots/azure-storage-accounts-redacted.png` — Storage account warnings.
- `screenshots/azure-rbac-redacted.png` — RBAC custom role gap.
- `screenshots/azure-ad-apps-redacted.png` — Azure AD applications inventory.
- Additional evidence: `screenshots/azure-network-watchers-redacted.png`, `azure-postgresql-redacted.png`, `azure-sql-database-redacted.png`, `azure-app-services-redacted.png`.
- CSV exports stored locally: `reports/Azure-Active-Directory-Applications-redacted.csv`, `reports/RBAC-Roles-redacted.csv`.

> Note: Keep raw ScoutSuite HTML, CSV exports, and unredacted screenshots out of Git to avoid leaking tenant IDs or app secrets.
