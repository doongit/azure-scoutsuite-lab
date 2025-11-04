# Cloud and AI Security Lab
This repository offers an Azure assessment, a secure LLM lab, and a curated Terraform landing zone. These resources show cloud security skills and enable multi-cloud and AI governance.

## Where the lab stands today
* Azure ScoutSuite review is complete, with redacted evidence linked in `scout-notes` and `screenshots`.
* The AI Security Lab offers a secure CLI, Streamlit app, and a threat model aligned with NIST AI RMF for identifying, assessing, and mitigating AI risks.
* The Terraform storage landing zone runs locally and uses Zero Trust defaults—access is always verified for every user and resource.
* Terraform Cloud and multi-cloud scan documentation is in `FUTURE-WORK.md`, pending approval.

## What lives in the repo
* `ScoutSuite/`  houses the local tool install and generated HTML report that stays out of Git.
* `scout-notes/azure-wgu-lab.md` contains the narrative report and links to evidence.
* `screenshots/` stores redacted PNGs such as `azure-dashboard-redacted.png`.
* `reports/` contains redacted CSV exports `Azure-Active-Directory-Applications-redacted.csv` and `RBAC-Roles-redacted.csv`.
* `ai-security-lab/` contains the demonstration of a large language model (LLM) that is aware of role-based access control (RBAC), meaning it restricts actions based on a user's assigned roles. It also includes the Streamlit web interface and the AI threat model.
* `terraform-iac-demo/` contains secure Terraform configs with policy guards.
* `FUTURE-WORK.md` provides the Terraform Cloud and governance activity roadmap.

## Run the Azure ScoutSuite workflow
```powershell
cd ScoutSuite
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
scout azure --cli --subscriptions <SUBSCRIPTION_ID>
```
Open the generated HTML in `ScoutSuite/scoutsuite-report`, capture redacted visuals, and update `scout-notes/azure-wgu-lab.md` with findings.

## Run the AI Security Lab
```powershell
cd ai-security-lab
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
copy .env.example .env
python secured-llm-app.py --user analyst_alice --action query --prompt "Explain zero trust in one line."
streamlit run app.py
```
The lab enforces role-based access control (RBAC) by verifying user permissions, filtering out prompts that could lead to unsafe AI outputs, and storing sensitive information in the .env file. The README describes how the system guards against risks and explains the threat model methodology.

## Terraform landing zone
The secure storage pattern is in `terraform-iac-demo`. The README provides instructions for local application setup, including the use of private endpoints and encryption defaults. Sentinel-style policy files are in `terraform-iac-demo/policies` as scaffolding for automation. Remote Terraform Cloud execution is planned, as noted in `FUTURE-WORK.md`, pending required subscription permissions.

## Future-ready items
`FUTURE-WORK.md` lists upcoming actions for multi-cloud, Terraform Cloud, AI governance, and certification proof for cloud and AI security.