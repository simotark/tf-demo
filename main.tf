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
  name     = "my-resource-group"
  location = "northeurope"
  tags = {
    environment = "dev"
    source      = "Terraform"
    owner       = "simo"
  }
}