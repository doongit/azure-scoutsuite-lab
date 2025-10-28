# Terraform Cloud Policy Set Automation

This configuration lets you manage the Sentinel policies located in `terraform-iac-demo/policies/` using Terraform Cloud itself. Rather than uploading Sentinel rules manually in the UI, run this configuration once (and whenever you change the policies) to publish the guardrails to the workspace.

## Usage

1. Export a Terraform Cloud API token with permissions to manage policy sets (Org Owner or “Manage policies” permission), for example:
   ```powershell
   $env:TFC_TOKEN = "sptfX..."
   ```

2. Populate a `terraform.tfvars` (or pass `-var` flags) with:
   ```hcl
   tfc_token          = "sptfX..."            # or rely on the env var TFC_TOKEN via TF_VAR_tfc_token
   tfc_organization   = "demeji-cloud"
   tfc_workspace_name = "azure-scoutsuite-lab"
   # policy_set_name  = "secure-storage-guardrails"  # optional override
   ```

3. Run Terraform:
   ```powershell
   cd tfc-policy-set
   terraform init
   terraform apply
   ```

   The run uploads the Sentinel files as a slug and attaches the policy set to the specified workspace. When you modify Sentinel policies, re-run `terraform apply` to push the updates.

## Inputs

| Variable | Description |
|----------|-------------|
| `tfc_token` | Terraform Cloud API token (sensitive). |
| `tfc_organization` | Terraform Cloud organization name. |
| `tfc_workspace_name` | Workspace that should receive the policy set. |
| `policy_set_name` | (Optional) Custom name for the policy set; defaults to `secure-storage-guardrails`. |

## Notes

- The policy set is marked `overridable = true`; adjust if you want to block overrides entirely.
- The policies remain hard-mandatory because that enforcement level is defined inside each `.sentinel` file.
- If you ever want to target multiple workspaces, replace `workspace_ids` with `workspace_tags` or a list of IDs.
