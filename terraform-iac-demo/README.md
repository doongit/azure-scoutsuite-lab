# Azure Secure IaC Demo - Terraform

This mini-project provisions a Zero Trust-inspired Azure landing zone that keeps data private by default:
- Private-only access via a Storage Account Private Endpoint
- Encryption enforced at the infrastructure layer and HTTPS-only traffic
- No public blob access and lifecycle guardrails (soft delete)
- Governance tags for ownership, environment, and project tracking
- Private DNS zone to keep name resolution on the internal network

## Resources Created
- Resource Group
- Storage Account (StorageV2, HTTPS-only, infrastructure encryption)
- Virtual Network and dedicated subnet for private endpoints
- Private DNS Zone plus VNet link for `privatelink.blob.core.windows.net`
- Private Endpoint bound to the Storage Account blob service

## Prerequisites
- [Terraform CLI](https://developer.hashicorp.com/terraform/downloads) v1.6.0 or newer
- Azure CLI logged into the subscription you want to use (`az login`)
- `az account set --subscription <SUBSCRIPTION_ID>` if you have multiple subscriptions

## Quick Start
```powershell
cd terraform-iac-demo

# 1. Copy the sample variables and tweak as needed
Copy-Item terraform.tfvars.example terraform.tfvars
# (Edit terraform.tfvars if you want to change region, naming prefix, etc.)

# 2. Initialize providers and modules
terraform init

# 3. Check the plan
terraform validate
terraform plan

# 4. Deploy the secure landing zone
terraform apply

# 5. Tear it down when you are done
terraform destroy
```

> Tip: Add `-auto-approve` to `terraform apply/destroy` if you want to skip the confirmation prompt during demos.

> Regional guardrail: the sample `terraform.tfvars` uses `westus`, which is on the allowed-locations policy for the WGU student subscription. If your tenant enforces a different list, update `location` in `terraform.tfvars` (or pass `-var "location=<region>"`) to one of the permitted regions before applying.

## Terraform Cloud / Terraform Enterprise Workflow
1. **Create a workspace** (Version Control workflow) and point it at this directory.  
2. **Add Azure credentials** as masked environment variables (`ARM_CLIENT_ID`, `ARM_CLIENT_SECRET`, `ARM_TENANT_ID`, `ARM_SUBSCRIPTION_ID`).  
3. **Move `terraform.tfvars` values into the workspace** under Variables. Optionally set `app_sp_object_id` to grant Storage Blob Data Contributor automatically.  
4. **Upload Sentinel policy set** (`policies/sentinel.hcl` + `.sentinel` files) to enforce:
   - No public network access or weak TLS on storage accounts.
   - Region must be in `var.sentinel_enforced_regions`.
5. **Use run tasks / policy checks** for approvals before applies. All runs are audited in the TFC GUI, helping satisfy CM-2 (CMMC) and NIST 3.4 requirements.

> Azure MFA and conditional access must be enforced in Entra ID. TFC protects Terraform operations (credentials, policy checks), while Entra ID governs the user/service principals authenticating to Azure.

## Testing Locally
Even without Azure credentials you can still lint the configuration:
```powershell
terraform -chdir=terraform-iac-demo fmt
terraform -chdir=terraform-iac-demo validate
```
Validation uses the provider schemas and catches syntax issues before running against Azure.

## Skills Demonstrated

- Infrastructure-as-Code (Terraform)
- Azure Security Architecture and Zero Trust patterns
- Encryption, Private Endpoints, and Private DNS
- Governance tagging and reusable infrastructure inputs
