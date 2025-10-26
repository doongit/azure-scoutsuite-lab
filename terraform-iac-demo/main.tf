##############################################
# Azure Secure Resource Group & Storage Demo
# Author: Doron Emeji
# Purpose: Demonstrate secure IaC with encryption, tagging, and private endpoint
##############################################

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }

  required_version = ">= 1.6.0"
}

provider "azurerm" {
  features {}
}

locals {
  # Storage account names must be globally unique, lowercase, and <= 24 chars
  storage_account_name = lower(substr("${var.storage_account_name_prefix}${random_string.suffix.result}", 0, 24))
}

# -----------------------------
# Resource Group
# -----------------------------
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Environment = "Demo"
    Owner       = "Doron Emeji"
    Project     = "Azure Zero Trust IaC"
  }
}

# -----------------------------
# Storage Account (Encrypted, HTTPS Only)
# -----------------------------
resource "azurerm_storage_account" "secure_storage" {
  name                              = local.storage_account_name
  resource_group_name               = azurerm_resource_group.rg.name
  location                          = azurerm_resource_group.rg.location
  account_tier                      = "Standard"
  account_replication_type          = "LRS"
  account_kind                      = "StorageV2"
  min_tls_version                   = "TLS1_2"
  infrastructure_encryption_enabled = true
  https_traffic_only_enabled        = true
  public_network_access_enabled     = false

  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }

  tags = {
    Purpose   = "Private Secure Storage"
    Managed   = "Terraform"
    ZeroTrust = "Enabled"
  }
}

# -----------------------------
# Virtual Network + Subnet for Private Endpoint
# -----------------------------
resource "azurerm_virtual_network" "vnet" {
  name                = "secure-vnet"
  address_space       = ["10.10.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "private_subnet" {
  name                 = "private-endpoint-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.10.1.0/24"]

  private_endpoint_network_policies_enabled     = true
  private_link_service_network_policies_enabled = true
}

# -----------------------------
# Private DNS Zone for Storage Endpoint
# -----------------------------
resource "azurerm_private_dns_zone" "storage_dns" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "storage_dns_link" {
  name                  = "secure-vnet-link"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.storage_dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

# -----------------------------
# Private Endpoint (to Storage)
# -----------------------------
resource "azurerm_private_endpoint" "storage_pe" {
  name                = "pe-secure-storage"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.private_subnet.id

  private_service_connection {
    name                           = "storage-connection"
    private_connection_resource_id = azurerm_storage_account.secure_storage.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "storage-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.storage_dns.id]
  }

  tags = {
    Purpose = "Private Access Only"
  }
}
