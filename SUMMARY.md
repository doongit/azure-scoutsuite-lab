# Azure ScoutSuite Findings Snapshot (2025-10-24)

| Service | Key Issue | Status |
|---------|-----------|--------|
| Azure AD | 100 findings driven by guest accounts and self-service group creation | Needs review |
| RBAC | No dedicated Resource Lock Administrator role; 803 objects scanned | Add custom role |
| Logging | Activity log alerts missing for policy + NSG events | Enable alerts & route to SOC |
| Security Center | Defender for Cloud plans and contacts disabled | Turn on plans & set contacts |
| Storage Accounts | Access keys not rotated; HTTPS-only not enforced | Apply Zero Trust storage baseline |
| Network | Network Watcher not enabled in region | Deploy watcher |
| Databases | SQL/PostgreSQL auditing & encryption disabled | Harden or disable services |

Redacted evidence: see `screenshots/azure-*-redacted.png` and CSV exports under `reports/`.
