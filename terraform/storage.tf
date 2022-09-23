############################################
# SETTING BOOT DIAGNOSTICS STORAGE ACCOUNT #
############################################

# CREATE: Storage Account for Boot Diagnostics
resource "azurerm_storage_account" "diag" {
  name                     = "diag${substr(local.unique_rg_string,0,10)}sa"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = merge(
      local.common_tags, 
      {
          display_name = "Diagnostics Storage Account"
      }
  )
}


# CREATE: Private DNS zone to blob endpoint
resource "azurerm_private_dns_zone" "blob" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.this.name
  
  tags = merge(
      local.common_tags, 
      {
          display_name = "Private DNS zone to resolve storage private endpoint."
      }
  )
}

# CREATE: Private Endpoint to Blob Storage for Diagnostics
resource "azurerm_private_endpoint" "diag" {
  name                = "${azurerm_storage_account.diag.name}-pe"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  subnet_id           = azurerm_subnet.this.id

  private_service_connection {
    name                           = "${azurerm_storage_account.diag.name}-pecon"
    private_connection_resource_id = azurerm_storage_account.diag.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

 private_dns_zone_group{
    name = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.blob.id]
 } 

  tags = merge(
      local.common_tags, 
      {
          display_name = "Private Endpoint to connect to Diagnostics Storage Account"
      }
  )

  depends_on = [
    azurerm_private_dns_zone.blob
  ]
}


# CREATE: Link Private DNS zone with Virtual Network
resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  name                  = azurerm_private_dns_zone.blob.name
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.blob.name
  virtual_network_id    = azurerm_virtual_network.this.id
  registration_enabled  = false
  
  tags = merge(
      local.common_tags, 
      {
          display_name = "Private DNS zone Link to VNET."
      }
  )
}