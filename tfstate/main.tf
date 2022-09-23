# Reference: https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=terraform

provider "azurerm" {
  features {}
}

variable "location" {
  type        = string
  description = "The Azure region where your resources will be created."
  default     = "southcentralus"
}

locals {
  unique_rg_string = md5(azurerm_resource_group.tfstate.id)

  storage_account_name = "tfstate${substr(local.unique_rg_string, 0, 10)}sa"

  tf_container_name = "tfstate"
}

resource "azurerm_resource_group" "tfstate" {
  name     = "tfstate"
  location = var.location
}

resource "azurerm_storage_account" "tfstate" {
  name                     = local.storage_account_name
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "tfstate"
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = local.tf_container_name
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "blob"
}

output "tf_resource_group_name" {
  value = azurerm_resource_group.tfstate.name
}

output "tf_storage_account_name" {
  value = azurerm_storage_account.tfstate.name
}

output "tf_storage_container" {
  value = azurerm_storage_container.tfstate.name
}