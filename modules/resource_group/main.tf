resource "azurerm_resource_group" "rg" {
  name     = var.obj_names["rg"]
  location = "northeurope"
  tags = {
    environment = var.obj_names["env"]
    source      = "Terraform"
    owner       = "simo"
  }
}