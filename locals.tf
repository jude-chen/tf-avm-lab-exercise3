locals {
  resource_group_name  = "${var.rg_name_prefix}-${var.location}-${var.rg_name_suffix}"
  virtual_network_name = "vnet-demo-dev-${var.location}-001"
}