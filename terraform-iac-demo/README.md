# Azure Secure Terraform Lab

This configuration delivers a private first storage landing zone that fits a Zero Trust story. It is designed as hands on evidence that you can secure Azure services with Terraform while keeping the door open for policy automation later.

## What the module builds
* Resource group with ownership, environment, and project tags.
* Storage account using StorageV2, TLS 1.2, infrastructure encryption, HTTPS only traffic, and soft delete.
* Virtual network plus subnet reserved for private endpoints.
* Private DNS zone for `privatelink.blob.core.windows.net` with a virtual network link.
* Private endpoint bound to the storage account blob service.

## Prerequisites
* Terraform CLI 1.6.0 or newer.
* Azure CLI authenticated to the target subscription with `az login`.
* Set the subscription using `az account set --subscription <SUBSCRIPTION_ID>` when you have more than one.

## Run the deployment
```powershell
cd terraform-iac-demo

# Copy sample variables
Copy-Item terraform.tfvars.example terraform.tfvars
# Adjust the sample values as needed

# Initialize providers
terraform init

# Validate and review the plan
terraform validate
terraform plan

# Apply the configuration
terraform apply

# Destroy when finished
terraform destroy
```

Tip: add `-auto-approve` to the apply or destroy command during demos when you want to skip the prompt.

Regional note: the sample variables use `westus`, which met the policy requirements in the student subscription. Update `location` in `terraform.tfvars` or pass `-var "location=<region>"` if your tenant enforces a different list.

## Policy guardrail scaffolding
The `policies` folder contains Sentinel style rules that deny public storage access and enforce allowed regions. They remain as scaffolding until Terraform Cloud automation goes live. The full cloud hosted workflow is laid out in `FUTURE-WORK.md`.

## Local quality checks
You can lint the configuration even without Azure credentials:
```powershell
terraform -chdir=terraform-iac-demo fmt
terraform -chdir=terraform-iac-demo validate
```

## Skills on display
* Infrastructure as Code with Terraform.
* Azure security architecture grounded in Zero Trust.
* Encryption, private endpoints, and private DNS patterns.
* Governance tagging and reusable inputs for DevSecOps pipelines.
