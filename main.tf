# provides configuration detauls for terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.31.1" #pessimistic operator; prevents major version change
    }
  }
}

# variable test
variable "my_variable" {}

# this tidbit needs to exist, lest an error occurreth 
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.my_variable
  location = "northeurope"
  tags = {
    environment = "dev"
    source      = "Terraform"
    owner       = "simo"
  }
}