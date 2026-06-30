terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  vm_size_sku = {
    small  = "Standard_B2s"
    middle = "Standard_D4s_v3"
    large  = "Standard_D8s_v3"
  }
}

resource "azurerm_linux_virtual_machine" "build_vm" {
  count               = var.vm_count
  name                = "build-vm-${var.request_id}-${count.index}"
  resource_group_name = azurerm_resource_group.build_rg.name
  location            = azurerm_resource_group.build_rg.location
  size                = local.vm_size_sku[lower(var.vm_size)]
  admin_username      = "adminuser"

  network_interface_ids = [
    azurerm_network_interface.build_nic[count.index].id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_id = var.azure_image_id

  tags = {
    request_id = var.request_id
    image_id   = var.vm_imageid
  }
}

resource "azurerm_resource_group" "build_rg" {
  name     = "rg-build-${var.request_id}"
  location = "East US"
}

resource "azurerm_virtual_network" "build_vnet" {
  name                = "vnet-build-${var.request_id}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.build_rg.location
  resource_group_name = azurerm_resource_group.build_rg.name
}

resource "azurerm_subnet" "build_subnet" {
  name                 = "subnet-build"
  resource_group_name  = azurerm_resource_group.build_rg.name
  virtual_network_name = azurerm_virtual_network.build_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "build_nic" {
  count               = var.vm_count
  name                = "nic-build-${var.request_id}-${count.index}"
  location            = azurerm_resource_group.build_rg.location
  resource_group_name = azurerm_resource_group.build_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.build_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
