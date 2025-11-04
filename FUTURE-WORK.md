# Future Work Roadmap

This roadmap outlines planned technical upgrades following the establishment of cloud credentials and trust levels to support organizational goals.

## Multi-cloud ScoutSuite expansion
* Goal: Adapt the Microsoft Azure playbook for Amazon Web Services (AWS) and Google Cloud Platform (GCP) to demonstrate broad cloud capability.
* Required: Secure read-only roles with MFA on AWS and GCP, and isolate scanning profiles.
* Steps:
  1. Run ScoutSuite scans for each provider and house the HTML output in a secure, access-controlled site external to the repository.
  2. Produce redacted evidence sets for identity, storage, logging, and threat detection, consistent with the Azure implementation.
  3. Revise the comparative analysis to align metrics and risks with CIS, NIST, and DoD standards.
* Deliverables: Supply redacted screenshots, updated summary, and key remediation strategies.

## Terraform Cloud automation
* Goal: Transition the secure landing zone to Terraform Cloud to log, test, and verify changes.
* Required: Provision an Azure service principal (Contributor role) and configure Terraform Cloud org with workspace and policy rights.
* Steps:
  1. Establish a Terraform Cloud workspace for `terraform-iac-demo` and enable remote execution capabilities.
  2. Secure Azure credentials as sensitive and migrate tfvars values into workspace variables.
  3. Enforce Sentinel-style policies in `terraform-iac-demo/policies` or an equivalent OPA stack, and document the initial policy-enforced execution.
  4. Gather screenshots and run identifiers as evidence, mapping them to NIST 800-53, CMMC, and Zero Trust requirements.
*  Deliverables: Present Terraform Cloud history documenting plan and apply outputs, policy evaluation logs, and a concise summary linking the workflow to RMF continuous monitoring.

## AI governance and GenAI controls
* Goal: Expand the AI Security Lab to govern AI risk and assure model integrity.
* Required: Complete training on NIST AI RMF, implement privacy templates, and access moderation APIs.
* Steps:
  1. Implement prompt logging with redaction, risk tags, and least privilege retention in the lab.
  2. Map controls to NIST AI RMF and log gaps in a structured register.
  3. Draft a sample assessment demonstrating lab compliance with DoD or EU AI requirements.
* Deliverables:  Offer updated threat model, governance checklist, and sample evidence for each control linked to compliance.

Once I receive cloud access, I will proceed with the roadmap and add the deliverables to our repository to support interviews and portfolio reviews.
