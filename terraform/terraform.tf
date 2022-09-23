terraform {
  required_version = ">= 1.1.3" 
  
  required_providers {
    azurerm  = "~> 3.0"
  }

  backend "azurerm" {
      resource_group_name  = "tfstate"
      storage_account_name = local.tf_storage_account_name
      container_name       = "tfstate"
      key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
    features {}
}

