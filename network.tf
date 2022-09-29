resource "azurerm_virtual_network" "main" {
  name                = "vnet-${local.resource_suffix}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  address_space       = [var.network_address_space]
}

resource "azurerm_subnet" "main" {
  name                                          = "default"
  resource_group_name                           = azurerm_resource_group.main.name
  virtual_network_name                          = azurerm_virtual_network.main.name
  address_prefixes                              = [var.network_address_space]
  private_link_service_network_policies_enabled = false
}

resource "azurerm_network_security_group" "main" {
  name                = "nsg-${local.resource_suffix}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  security_rule {
    name                       = "AllowLoadBalancerInbound"
    access                     = "Allow"
    priority                   = 100
    destination_address_prefix = "VirtualNetwork"
    destination_port_range     = "60000-60001"
    source_address_prefix      = "AzureLoadBalancer"
    source_port_range          = "*"
    direction                  = "Inbound"
    protocol                   = "Tcp"
  }
}

resource "azurerm_subnet_network_security_group_association" "main" {
  subnet_id                 = azurerm_subnet.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}

resource "azurerm_role_assignment" "network_contributor" {
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.main.principal_id
  scope                = azurerm_virtual_network.main.id
}
