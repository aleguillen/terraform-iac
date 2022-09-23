# GET: Current Azure RM context details
data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "tfstate" {
  name      = local.tf_resource_group_name
}

# CREATE: Resource Group
resource "azurerm_resource_group" "this" {
  name      = local.rg_name
  location  = var.location
  tags = merge(
    local.common_tags, 
    {
        created  = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
    }
  )
  
  lifecycle {
    ignore_changes = [
      tags["created"],
    ]
  }
}

# GET: Configuration cloudinit file.
data "template_file" "cloudinit" {
  template = file("${path.module}/scripts/cloudinit.sh")
}

data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    content = data.template_file.cloudinit.rendered
  }
}

# CREATE: Private/Public SSH Key for Linux Virtual Machine or VMSS
resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
