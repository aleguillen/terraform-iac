locals {
  # Following Azure Naming Conventions: 
  # https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging

  # General
  naming_conv = "${var.prefix}-${var.environment_name}"
  
  unique_rg_string = md5(azurerm_resource_group.this.id)
  
  rg_name   = "rg-${local.naming_conv}-${var.location}-001"

  vnet_name   = "vnet-${local.naming_conv}-${var.location}-001"

  nsg_name   = "nsg-${local.naming_conv}-default"

  vm_name   = "vm-${local.naming_conv}-${var.location}-001"

  nic_name   = "nic-${local.vm_name}"
  
  vm_os_disk_name = "osdisk-${local.vm_name}"

  common_tags = merge(
    var.common_tags, 
    {
      environment = var.environment_name
    }
  )
  
  # Terraform constants
  
  tf_unique_rg_string = md5(data.azurerm_resource_group.tfstate.id)

  tf_resource_group_name = "tfstate"

  tf_storage_account_name = "tfstate${substr(local.tf_unique_rg_string,0,10)}sa"
  
  tf_container_name = "tfstate"

  tf_key = "terraform.tfstate"

}
