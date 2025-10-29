# Future Work Roadmap

This plan tracks the next set of upgrades once cloud credentials and higher trust levels are available.

## Multi cloud ScoutSuite expansion
* Goal: Apply the Azure playbook to AWS and GCP to prove depth across providers.
* Inputs needed: Read only roles with MFA on AWS and GCP along with isolated profiles for scanning.
* Steps:
  1. Run ScoutSuite against each provider and store HTML output outside the repo.
  2. Create redacted evidence that mirrors the Azure set for identity, storage, logging, and threat detection.
  3. Update the comparison write up with real metrics and risks that map to CIS, NIST, and DoD guidance.
* Expected proof: Redacted screenshots, a refreshed comparison note, and a talking point on shared remediation themes.

## Terraform Cloud automation
* Goal: Move the secure landing zone into Terraform Cloud so every change is logged, tested, and policy checked.
* Inputs needed: Azure service principal with Contributor on the target subscription and a Terraform Cloud org with workspace and policy rights.
* Steps:
  1. Create a Terraform Cloud workspace for `terraform-iac-demo` using remote execution.
  2. Load Azure credentials as sensitive environment variables and migrate `terraform.tfvars` values into workspace variables.
  3. Enable the Sentinel style policies in `terraform-iac-demo/policies` or an equivalent OPA stack and record the first policy enforced run.
  4. Capture screenshots and run IDs for evidence tied to NIST 800-53, CMMC, and Zero Trust requirements.
* Expected proof: Terraform Cloud history showing plan and apply outputs, policy evaluation logs, and a short write up connecting the flow to RMF continuous monitoring.

## AI governance and GenAI controls
* Goal: Extend the AI Security Lab to cover AI risk governance and model assurance.
* Inputs needed: Training on NIST AI RMF, privacy review templates, and access to moderation or watermarking APIs.
* Steps:
  1. Add prompt logging with redaction, risk tagging, and least privilege retention to the existing lab.
  2. Map current controls to NIST AI RMF functions and document open gaps in a simple register.
  3. Produce a sample assessment that explains how the lab would meet DoD or EU AI policy checkpoints.
* Expected proof: Updated threat model, governance checklist, and a short blog style summary suitable for recruiters and hiring managers.

Advance this roadmap as soon as cloud access is granted, then fold the deliverables back into the repo so they support interviews and portfolio reviews.
