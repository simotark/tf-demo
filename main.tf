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

module "res group" {
  source = "./modules/resource_group/main.tf"
  
}
output "rg_id" {
  value = azurerm_resource_group.rg.id
}