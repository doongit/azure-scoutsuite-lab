output "resource_group_name" {
  description = "Name of the resource group created by this module"
  value       = azurerm_resource_group.rg.name
}

output "storage_account_endpoint" {
  description = "Primary blob endpoint for the secure storage account"
  value       = azurerm_storage_account.secure_storage.primary_blob_endpoint
}

output "private_endpoint_ip" {
  description = "Private IP address assigned to the storage account private endpoint"
  value       = azurerm_private_endpoint.storage_pe.private_service_connection[0].private_ip_address
}
