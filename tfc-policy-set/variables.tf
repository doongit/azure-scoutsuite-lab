variable "tfc_token" {
  description = "Terraform Cloud/Enterprise API token with permissions to manage policy sets"
  type        = string
  sensitive   = true
}

variable "tfc_organization" {
  description = "Terraform Cloud organization name"
  type        = string
}

variable "tfc_workspace_name" {
  description = "Workspace that should receive the Sentinel policy set"
  type        = string
}

variable "policy_set_name" {
  description = "Name for the Sentinel policy set"
  type        = string
  default     = "secure-storage-guardrails"
}
