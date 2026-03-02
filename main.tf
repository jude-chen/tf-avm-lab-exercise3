module "avm-res-resources-resourcegroup" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "0.2.2"
  # insert the 2 required variables here
  name     = local.resource_group_name
  location = var.location
}

module "avm-res-network-virtualnetwork" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.17.1"
  # insert the 2 required variables here
  parent_id     = module.avm-res-resources-resourcegroup.resource_id
  name          = local.virtual_network_name
  address_space = [var.address_space]
  location      = var.location
}

module "avm-res-network-virtualnetwork_subnet" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm//modules/subnet"
  version = "0.17.1"
  # insert the 2 required variables here
  name           = var.subnet_name
  parent_id      = module.avm-res-network-virtualnetwork.resource_id
  address_prefix = var.address_space
}

module "private_dns_zone" {
  source  = "Azure/avm-res-network-privatednszone/azurerm"
  version = "0.4.0"

  domain_name = "privatelink.blob.core.windows.net"
  parent_id   = module.avm-res-resources-resourcegroup.resource_id
  virtual_network_links = {
    vnetlink1 = {
      name   = "storage-account"
      vnetid = module.avm-res-network-virtualnetwork.resource_id
    }
  }
}

module "storage_account" {
  source  = "Azure/avm-res-storage-storageaccount/azurerm"
  version = "0.6.3"

  location            = var.location
  name                = var.storage_account_name
  resource_group_name = module.avm-res-resources-resourcegroup.name
  containers = {
    demo = {
      name = "demo"
    }
  }
  private_endpoints = {
    primary = {
      private_dns_zone_resource_ids = [module.private_dns_zone.resource_id]
      subnet_resource_id            = module.avm-res-network-virtualnetwork_subnet.resource_id
      subresource_name              = "blob"
    }
  }
}
