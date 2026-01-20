variable "location" {
  type        = string
  description = "Azure region."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name."
}

variable "vnet_name" {
  type        = string
  description = "VNet name."
}

variable "subnet_name" {
  type        = string
  description = "Subnet name."
}

variable "vnet_address_space" {
  type        = list(string)
  description = "VNet CIDR blocks."
}

variable "subnet_address_prefixes" {
  type        = list(string)
  description = "Subnet CIDR blocks."
}
