##############################################
# Optional IAM bindings managed via Terraform
##############################################

locals {
  storage_role_assignments_enabled = length(trimspace(var.app_sp_object_id)) > 0
}

resource "azurerm_role_assignment" "storage_blob_contributor" {
  count                = local.storage_role_assignments_enabled ? 1 : 0
  scope                = azurerm_storage_account.secure_storage.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.app_sp_object_id
  depends_on = [
    azurerm_private_endpoint.storage_pe
  ]
}

# Future policy-as-code tooling can inspect var.sentinel_enforced_regions to ensure location compliance.
