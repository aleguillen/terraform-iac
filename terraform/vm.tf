# CREATE: Network Interface for Azure Linux VM
resource "azurerm_network_interface" "this" {
  name                = local.nic_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.this.id
    private_ip_address_allocation = "Dynamic"
  }
  
  tags = merge(
    local.common_tags, 
    {
        display_name = "NIC for VM"
    }
  )
}

# CREATE: Azure Linux VM 
resource "azurerm_linux_virtual_machine" "this" {
  name                  = local.vm_name
  location              = azurerm_resource_group.this.location
  resource_group_name   = azurerm_resource_group.this.name
  network_interface_ids = [azurerm_network_interface.this.id]
  size               = var.vm_size

  computer_name  = local.vm_name
  admin_username = var.vm_username
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.vm_username
    public_key = tls_private_key.this.public_key_openssh
  }
  

  # Cloud Init Config file
  custom_data = data.template_cloudinit_config.config.rendered

  os_disk {
    name              = local.vm_os_disk_name
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  # If vm_image_id is specified will use this instead of source_image_reference default settings
  source_image_id =  length(var.vm_image_id) > 0 ? var.vm_image_id : null

  dynamic "source_image_reference" {
    for_each = length(var.vm_image_id) > 0 ? [] : [var.vm_image_ref]
    content {
      publisher = lookup(var.vm_image_ref, "publisher", "Canonical")
      offer     = lookup(var.vm_image_ref, "offer", "UbuntuServer")
      sku       = lookup(var.vm_image_ref, "sku", "18.04-LTS")
      version   = lookup(var.vm_image_ref, "version", "latest")
    }
  }

  identity {
    type = "SystemAssigned"
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.diag.primary_blob_endpoint
  }

  tags = merge(
    local.common_tags, 
    {
        display_name = "Azure VM"
    }
  )
}

