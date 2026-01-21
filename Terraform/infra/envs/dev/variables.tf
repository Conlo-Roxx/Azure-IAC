variable "location" {
  type        = string
  description = "Azure region."
  default     = "uksouth"
}

variable "name_prefix" {
  type        = string
  description = "Short prefix used in resource names."
  default     = "demo"
}

variable "environment" {
  type        = string
  description = "Environment name (dev/prod)."
  default     = "dev"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space for the VNet."
  default     = ["10.10.0.0/16"]
}

variable "subnet_address_prefixes" {
  type        = list(string)
  description = "Address prefixes for the subnet."
  default     = ["10.10.1.0/24"]
}

variable "admin_password" {
  description = "VM Account Password (sensitive)"
  type        = string
  sensitive   = true
}