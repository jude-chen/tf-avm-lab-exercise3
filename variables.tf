variable "location" {
  type        = string
  description = "The region to deploy the resources to"
}

# variable "resource_group_name" {
#   type        = string
#   description = "The name of the resource group for the Storage Account and App Configuration which will contain the terraform backend and exported values"
# }

variable "rg_name_prefix" {
  type        = string
  description = "Prefix of the resource group name"
}

variable "rg_name_suffix" {
  type        = string
  description = "Suffix of the resource group name"
}

variable "address_space" {
  type        = string
  description = "The address space for the virtual network"
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet"
}

variable "storage_account_name" {
  type        = string
  description = "The name of the storage account"
}

variable "tags" {
  type = map(string)
}

variable "address_prefixes" {
  type        = map(string)
  description = "The address prefix size for each subnet"
}
