terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.44"
    }
  }
}

provider "tfe" {
  hostname = "app.terraform.io"
  token    = var.tfc_token
}

data "tfe_workspace" "target" {
  name         = var.tfc_workspace_name
  organization = var.tfc_organization
}

# Package the Sentinel policies living under terraform-iac-demo/policies
data "tfe_slug" "secure_storage_guardrails" {
  source_path = "../terraform-iac-demo/policies"
}

resource "tfe_policy_set" "secure_storage_guardrails" {
  name                 = var.policy_set_name
  description          = "Sentinel guardrails for the secure storage landing zone"
  organization         = var.tfc_organization
  kind                 = "sentinel"
  policy_tool_version  = "latest"
  agent_enabled        = true
  overridable          = true
  slug                 = data.tfe_slug.secure_storage_guardrails.id
  workspace_ids        = [data.tfe_workspace.target.id]
}
