# Cloud and AI Security Lab
Hands on Azure assessment, a secured LLM lab, and an opinionated Terraform landing zone packaged to showcase cloud security skills with room to expand into multi cloud and AI governance.

## Where the lab stands today
* Azure ScoutSuite review is complete with redacted evidence linked in `scout-notes` and `screenshots`.
* AI Security Lab delivers a guarded CLI and Streamlit app plus a NIST AI RMF aligned threat model.
* Terraform secure storage landing zone runs locally and highlights Zero Trust defaults.
* Terraform Cloud automation and multi cloud scans sit in `FUTURE-WORK.md` until elevated access is approved.

## What lives in the repo
* `ScoutSuite/` houses the local tool install and generated HTML report that stays out of Git.
* `scout-notes/azure-wgu-lab.md` keeps the narrative report tied back to specific evidence.
* `screenshots/` stores redacted PNGs such as `azure-dashboard-redacted.png`.
* `reports/` contains redacted CSV exports `Azure-Active-Directory-Applications-redacted.csv` and `RBAC-Roles-redacted.csv`.
* `ai-security-lab/` includes the RBAC aware LLM demo, Streamlit front end, and AI threat model.
* `terraform-iac-demo/` contains the secure landing zone Terraform with policy guardrail scaffolding.
* `FUTURE-WORK.md` spells out the roadmap for Terraform Cloud, multi cloud, and governance follow ups.

## Evidence guidelines
* Keep raw ScoutSuite HTML, CSV exports, and unredacted screenshots outside version control.
* Name redacted screenshots clearly and store them under `screenshots`.
* Reference evidence paths inside the notes so reviewers can trace each finding.

## Run the Azure ScoutSuite workflow
```powershell
cd ScoutSuite
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
scout azure --cli --subscriptions <SUBSCRIPTION_ID>
```
Open the generated HTML under `ScoutSuite/scoutsuite-report`, capture redacted visuals, and refresh `scout-notes/azure-wgu-lab.md` with any new insights.

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
The lab enforces RBAC, filters unsafe prompts, and keeps secrets in `.env`. The README inside the folder covers guardrail demos and the threat model.

## Terraform landing zone
The secure storage pattern lives in `terraform-iac-demo`. The README explains how to apply it locally with private endpoints and encryption defaults. Sentinel style policy files remain in `terraform-iac-demo/policies` as scaffolding for future automation. Remote Terraform Cloud execution is staged in `FUTURE-WORK.md` once the correct subscription permissions are available.

## Future ready items
`FUTURE-WORK.md` outlines next moves for multi cloud ScoutSuite runs, Terraform Cloud integration, AI governance evidence, and certification proof points that align with cloud and AI security architect expectations.
