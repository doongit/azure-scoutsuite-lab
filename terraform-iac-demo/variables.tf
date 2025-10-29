variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "westus3"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-secure-demo"
}

variable "storage_account_name_prefix" {
  description = "Prefix used for the storage account name with a random suffix for uniqueness"
  type        = string
  default     = "securestoragedemo"
}

variable "app_sp_object_id" {
  description = "Object ID of the service principal or managed identity that needs Storage Blob Data Contributor access"
  type        = string
  default     = ""
}

variable "sentinel_enforced_regions" {
  description = "Approved Azure regions enforced by future policy guardrails"
  type        = list(string)
  default     = ["westus", "westus3", "northcentralus", "mexicocentral", "eastus2"]
}

resource "random_string" "suffix" {
  length  = 5
  upper   = false
  numeric = true
  special = false
}
