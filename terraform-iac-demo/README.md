# Azure Secure Terraform Lab

This configuration creates a private-first storage landing zone in line with Zero Trust principles. It demonstrates that Terraform secures Azure services and supports future policy automation.

## What the module builds
* Provision a resource group with ownership, environment, and project tags.
* Deploy a StorageV2 account using TLS 1.2, enforces infrastructure encryption, restricts traffic to HTTPS, and enables soft delete.
* Establish a virtual network and subnet reserved for private endpoints.
* Configure a private DNS zone for `privatelink.blob.core.windows.net` and link it to the virtual network.
* Bind a private endpoint to the storage account blob service.

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

Tip: To bypass confirmation prompts during demonstrations, add `-auto-approve` to the apply or destroy command.

Regional note: The sample variables specify `westus`, which satisfied policy requirements in the student subscription. Update the `location` value in `terraform.tfvars` or use `-var "location=<region>"` if your tenant enforces a different region list.

## Policy guardrail scaffolding
The `policies` folder contains Sentinel-style rules that deny public storage access and enforce region restrictions. Refer to the policies folder in the repository root for these scaffolding rules. They are intended as interim measures until Terraform Cloud automation is implemented. Details on the full cloud-hosted workflow can be found in `FUTURE-WORK.md`.

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
