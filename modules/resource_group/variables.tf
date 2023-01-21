variable "obj_names" {
  type = map(any)
  default = {
    "rg"  = "my_resource_group"
    "env" = "dev"
  }
}