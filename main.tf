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

variable "obj_names" {
  type = map(any)
  default = {
    "rg"  = "my_resource_group"
    "env" = "dev"
  }
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
