terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 2.0" 
    }    
  }
}

# Configure the Azure provider
provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}

# Create a new resource group
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location

  tags = var.tags
}

# create a virtual network

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.resource_prefix}${var.subnet_name}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_prefixes
}

resource "azurerm_public_ip" "publicip" {
  name                 = var.public_IP
  location             = var.location
  resource_group_name  = azurerm_resource_group.rg.name
  allocation_method    = "Static"
}

resource "azurerm_network_security_group" nsg {
  name                  = var.security_group_name
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg.name

  security_rule {
    name                        = "SSH"
    priority                    = 1002
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }
}

resource "azurerm_network_interface" "nic" {
  name                          = "server_nic"
  location                      = var.location
  resource_group_name           = azurerm_resource_group.rg.name

  ip_configuration {
    name                        = "server_ip"
    subnet_id                   = azurerm_subnet.subnet.id
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip.id
  }
} 

resource "azurerm_network_interface_security_group_association" "nic-nsg" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Create a Linux virtual machine
resource "azurerm_virtual_machine" "vm" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = "Standard_DS1_v2"

  storage_os_disk {
    name              = "${var.vm_name}OsDisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = var.vm_hostname
    admin_username = var.vm_username
    admin_password = var.vm_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}