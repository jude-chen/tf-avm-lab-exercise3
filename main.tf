module "avm-res-resources-resourcegroup" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "0.2.2"
  # insert the 2 required variables here
  name     = local.resource_group_name
  location = var.location
}

