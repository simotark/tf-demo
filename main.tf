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
    source      = "Terraform"
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

# works, but outputs block plan
#resource "local_file" "output" {
#  content  = azurerm_virtual_network.vnet.name
#  filename = "outputs.tf"
#}