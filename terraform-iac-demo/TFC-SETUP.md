# Terraform Cloud / Enterprise Integration Checklist

This repo already contains the Terraform configuration, IAM bindings, and Sentinel policies needed to run in Terraform Cloud (TFC) or Terraform Enterprise (TFE). Use this checklist to wire everything together with NIST 800-171 / CMMC guardrails in mind.

## 1. Workspace & VCS
- Create a new workspace and connect it to the Git repo.
- Set the working directory to `terraform-iac-demo`.
- Choose `Execution Mode: Remote` so all plans/applies happen in TFC/TFE.

## 2. Secure Variables
- Add the Azure service principal credentials as **environment variables** (`ARM_CLIENT_ID`, `ARM_CLIENT_SECRET`, `ARM_TENANT_ID`, `ARM_SUBSCRIPTION_ID`). Mark them as sensitive.
- Add Terraform variables (`location`, `resource_group_name`, `app_sp_object_id`, etc.) in the **Variables** tab.
- Remove `terraform.tfvars` from version control if you don’t want defaults committed.

## 3. Sentinel Policy Set
- Create a policy set in your organization (GUI → Policies → Policy sets).
- Point it at `terraform-iac-demo/policies`.
- Ensure `sentinel.hcl` is recognized with:
  ```hcl
  policy "deny_public_storage" {
    enforcement_level = "hard-mandatory"
  }
  policy "enforce_allowed_regions" {
    enforcement_level = "hard-mandatory"
  }
  ```
- These policies check the plan before apply. Failed policy = failed run.

## 4. Optional Azure Policy Alignment
- Use Terraform to assign Azure Policy definitions (e.g., “Deny public storage access”, “Require diagnostic settings”).
- Azure Policy catches drift outside Terraform, complementing Sentinel.

## 5. NIST 800-171 / CMMC Evidence Pointers
| Control Area | Evidence Source |
|--------------|----------------|
| CM (Configuration Management) | Version-controlled Terraform code + TFC run history |
| AC / SC (Access & Network Controls) | IaC enforcing private endpoint, TLS 1.2+, RBAC |
| AU / IR (Audit & Response) | Add diagnostic settings resources + Sentinel policy requiring them |
| Risk & Governance | Policy set audit logs, run approvals, Azure Policy assignments |

## 6. MFA & Privileged Access
- Enforce MFA/conditional access in Entra ID for both human admins and service principals (via PIM).
- Document this in your SSP; TFC guards Terraform runs but cannot enforce Entra MFA.

## 7. Promotion Path
- Use separate workspaces (`secure-storage-dev`, `secure-storage-prod`) and Terraform variables for each environment.
- Promote via VCS branch workflows or workspace run tasks.

With these steps you get click-to-run infrastructure, policy checks baked into each plan, and audit trails that support your compliance narrative.
