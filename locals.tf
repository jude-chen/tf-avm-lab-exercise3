locals {
  resource_group_name  = "${var.rg_name_prefix}-${var.location}-${var.rg_name_suffix}"
  virtual_network_name = "vnet-demo-dev-${var.location}-001"
  diagnostic_settings = {
    sendToLogAnalytics = {
      name                  = "sendToLogAnalytics"
      workspace_resource_id = module.avm-res-operationalinsights-workspace.resource_id
    }
  }
  law_name = "law-demo-dev-${var.location}-001"
}