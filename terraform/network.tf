
# CREATE: Network Security Group - prevent inbound internet connection.
resource "azurerm_network_security_group" "this" {
  name                = local.nsg_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  tags = merge(
    local.common_tags, 
    {
        display_name = "Network Security Group - Default Subnet"
    }
  )
}

# CREATE: Virtual Network
resource "azurerm_virtual_network" "this" {
  name                = local.vnet_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = ["10.0.0.0/16"]

  tags = merge(
    local.common_tags, 
    {
        display_name = "Virtual Network"
    }
  )
}

# CREATE: Subnet
resource "azurerm_subnet" "this" {
  name                 = "snet-default"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.0.0/24"]

  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies = true

}

# CREATE: Subnet to Remove
resource "azurerm_subnet" "remove" {
  name                 = "snet-to-remove"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.1.0/24"]
}

# UPDATE: Assign Network Security Group to Subnet
resource "azurerm_subnet_network_security_group_association" "this" {
  subnet_id                 = azurerm_subnet.this.id
  network_security_group_id = azurerm_network_security_group.this.id
}

# resource "azurerm_subnet" "new" {
#   name                 = "snet-new"
#   resource_group_name  = azurerm_resource_group.this.name
#   virtual_network_name = azurerm_virtual_network.this.name
#   address_prefixes     = ["10.0.2.0/24"]
# }