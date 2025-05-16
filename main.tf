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
  name                      = "peer1to2"
  resource_group_name       = azurerm_resource_group.vnet.name
  virtual_network_name      = var.vnet_name1
  remote_virtual_network_id = azurerm_virtual_network.vnet-2.id
}

resource "azurerm_virtual_network_peering" "vnet-2" {
  name                      = "peer2to1"
  resource_group_name       = azurerm_resource_group.vnet.name
  virtual_network_name      = var.vnet_name2
  remote_virtual_network_id = azurerm_virtual_network.vnet-1.id
}

resource "azurerm_subnet" "vnet-1" {
  name                 = var.vnet_subnet1
  resource_group_name  = azurerm_resource_group.vnet.name
  virtual_network_name = azurerm_virtual_network.vnet-1.name
  address_prefixes     = var.vnet1_subnet_address_prefix
}

resource "azurerm_subnet" "vnet-2" {
  name                 = var.vnet_subnet2
  resource_group_name  = azurerm_resource_group.vnet.name
  virtual_network_name = azurerm_virtual_network.vnet-2.name
  address_prefixes     = var.vnet2_subnet_address_prefix
}

resource "azurerm_network_interface" "vnet-1-nic" {
  name                = var.vnet1_nic
  location            = var.azure_region
  resource_group_name = azurerm_resource_group.vnet.name

  ip_configuration {
    name                          = "matti-vnet1-ipconfig"
    subnet_id                     = azurerm_subnet.vnet-1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "vnet-2-nic" {
  name                = var.vnet2_nic
  location            = var.azure_region
  resource_group_name = azurerm_resource_group.vnet.name

  ip_configuration {
    name                          = "matti-vnet2-ipconfig"
    subnet_id                     = azurerm_subnet.vnet-2.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vnet1-vm" {
  name                  = var.vnet1_vm
  location              = var.azure_region
  resource_group_name   = azurerm_resource_group.vnet.name
  network_interface_ids = [azurerm_network_interface.vnet-1-nic.id]
  vm_size               = var.vm_size

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "testname"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = "staging"
  }
}

resource "azurerm_virtual_machine" "vnet2-vm" {
  name                  = var.vnet2_vm
  location              = var.azure_region
  resource_group_name   = azurerm_resource_group.vnet.name
  network_interface_ids = [azurerm_network_interface.vnet-2-nic.id]
  vm_size               = var.vm_size

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myosdisk2"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "testname"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = "staging"
  }

}