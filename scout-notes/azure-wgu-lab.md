# Azure ScoutSuite Story

## Scan snapshot
* Tool: ScoutSuite 5.14.0 from the local CLI.
* Subscription: Azure for Students ID `47180d00-d49b-4d40-9d0c-e830e30d609d`.
* Date: 24 Oct 2025.
* Evidence: Redacted HTML, screenshots, and CSV exports kept out of version control.

The dashboard view `azure-dashboard-redacted.png` notes 381 Azure AD objects, 803 RBAC entries, and one hundred total findings across identity, monitoring, and storage.

## Identity and RBAC
* Guest invitations stay open and self service group creation is active. Review the process and enforce MFA for external accounts.
* No custom role protects resource locks. Build a scoped lock administrator role to prevent accidental unlocks.
* Evidence lives in `reports/Azure-Active-Directory-Applications-redacted.csv`, `reports/RBAC-Roles-redacted.csv`, and `screenshots/azure-rbac-redacted.png`.

## Monitoring and Defender for Cloud
* Diagnostic settings do not ship logs to Log Analytics.
* Activity alerts are not raised for policy assignment, NSG edits, SQL firewall changes, or Defender events.
* Defender for Cloud plans and security contacts are off.
* Evidence: `azure-logging-alerts-redacted.png`, `azure-security-center-redacted.png`.

## Storage and network
* Storage keys are stale, public access remains possible, and HTTPS only is not enforced on custom domains.
* Network Watcher is not deployed in the active region.
* Evidence: `azure-storage-accounts-redacted.png`, `azure-network-watchers-redacted.png`.

## Data and platform
* SQL and PostgreSQL lack auditing, encryption, vulnerability assessment, and retention policies.
* App Service reminders call for authentication, client certificates, FTPS only, TLS 1.2, and supported runtimes. No virtual machines were flagged.
* Evidence: `azure-postgresql-redacted.png`, `azure-sql-database-redacted.png`, `azure-app-services-redacted.png`.

## Immediate actions
1. Enable diagnostic settings and activity alerts that flow to Log Analytics or the SOC mailbox.
2. Stand up the resource lock administrator role and tighten guest access.
3. Apply the secure storage baseline, rotate keys, and enforce HTTPS only settings.
4. Turn on Defender for Cloud plans and add incident contacts.
5. Harden database and App Service configurations or retire unused services.

## Evidence index
* `screenshots/azure-dashboard-redacted.png`
* `screenshots/azure-logging-alerts-redacted.png`
* `screenshots/azure-security-center-redacted.png`
* `screenshots/azure-storage-accounts-redacted.png`
* `screenshots/azure-rbac-redacted.png`
* `screenshots/azure-ad-apps-redacted.png`
* `screenshots/azure-network-watchers-redacted.png`
* `screenshots/azure-postgresql-redacted.png`
* `screenshots/azure-sql-database-redacted.png`
* `screenshots/azure-app-services-redacted.png`
* CSV exports stored locally: `reports/Azure-Active-Directory-Applications-redacted.csv`, `reports/RBAC-Roles-redacted.csv`

Keep raw HTML, CSV, and unredacted visuals outside Git to protect tenant identifiers and secrets.
