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
  name     = var.obj_names["rg"]
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

resource "azurerm_virtual_network" "name" {
  name                = "network makes the dream work"
  location            = "northeurope"
  resource_group_name = "azurerm_resource_group.rg"
  address_space       = ["10.0.0.0/16"]

  depends_on = [
    azurerm_resource_group.rg
  ]
}