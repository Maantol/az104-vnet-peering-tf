resource "azurerm_resource_group" "vnet" {
  name     = var.resource_group_name
  location = var.azure_region
}

resource "azurerm_virtual_network" "vnet-1" {
  name                = var.vnet_name1
  resource_group_name = azurerm_resource_group.vnet.name
  address_space       = var.vnet1_address_space
  location            = var.azure_region
}

resource "azurerm_virtual_network" "vnet-2" {
  name                = var.vnet_name2
  resource_group_name = azurerm_resource_group.vnet.name
  address_space       = var.vnet2_address_space
  location            = var.azure_region
}

resource "azurerm_virtual_network_peering" "vnet-1" {
  name                      = var.vnet_peering1
  resource_group_name       = azurerm_resource_group.vnet.name
  virtual_network_name      = var.vnet_name1
  remote_virtual_network_id = azurerm_virtual_network.vnet-2.id
}

resource "azurerm_virtual_network_peering" "vnet-2" {
  name                      = var.vnet_peering2
  resource_group_name       = azurerm_resource_group.vnet.name
  virtual_network_name      = var.vnet_name2
  remote_virtual_network_id = azurerm_virtual_network.vnet-1.id
}