variable "prefix" {
  type        = string
  description = "The prefix for all your resources. Ex.: <prefix>-rg, <prefix>-vnet"
  default = "tfiac"
}

variable "environment_name" {
  type        = string
  description = "Environment Name."
  default     = "lab"
}

variable "location" {
  type        = string
  description = "The Azure region where your resources will be created."
}

variable "common_tags" {
    type = map(string)
    description = "Common resources tags. Key-value pair"
    default = {}
}

variable "vm_size" {
  type        = string
  description = "Virtual Machine SKU size."
  default     = "Standard_DS1_v2"
}

variable "vm_username" {
  type        = string
  description = "The username for the Azure VM."
  default = "labadmin"
}

variable "vm_image_id" {
  type        = string
  description = "The VM Image Id to use for the VM."
  default     = ""
}

variable "vm_image_ref" {
  type        = map(string)
  description = "The VM Image Reference if not using Golden Images."
  default     = {
    publisher = "Canonical",
    offer     = "UbuntuServer",
    sku       = "18.04-LTS",
    version   = "latest"
  }
}
