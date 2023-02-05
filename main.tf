# provides configuration detauls for terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.31.1" #pessimistic operator; prevents major version change
    }
  }
}

# this tidbit needs to exist, lest an error occurreth 
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  #  name     = var.obj_names["rg"]
  name     = var.resource_group
  location = "northeurope"
  tags = {
    environment = var.obj_names["env"]
    source      = local.lahde
    owner       = "simo"
  }
}
output "rg_id" {
  value = azurerm_resource_group.rg.id
}

resource "azurerm_virtual_network" "vnet" {
  name                = "network_makes_the_dream_work"
  location            = "northeurope"
  resource_group_name = var.resource_group
  address_space       = ["10.0.0.0/16"]

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_subnet" "subnet" {
  virtual_network_name = azurerm_virtual_network.vnet.name
  name                 = "subu-net"
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "nic" {
  name                = "vm-nic"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  ip_configuration {
    name                          = "just-an-ip"
    private_ip_address_allocation = "dynamic"
    subnet_id                     = azurerm_subnet.subnet.id
  }
}

# barebones, but passes validation
resource "azurerm_virtual_machine" "vm" {
  count                 = 1
  name                  = "Ville-Matti"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  vm_size               = "Standard_B1s"
  network_interface_ids = [azurerm_network_interface.nic.id]
  storage_os_disk {
    name          = "ossi-disk"
    create_option = "FromImage"
  }
}

# works, but outputs block plan
#resource "local_file" "output" {
#  content  = azurerm_virtual_network.vnet.name
#  filename = "outputs.tf"
#}