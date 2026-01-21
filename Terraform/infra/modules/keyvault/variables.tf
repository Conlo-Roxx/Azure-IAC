variable "resource_group_name" {
  type        = string
  description = "Resource group name to create the Key Vault in."
}

variable "location" {
  type        = string
  description = "Azure region for the Key Vault."
}

variable "key_vault_name" {
  type        = string
  description = "Name of the Key Vault."
}

variable "tenant_id" {
  type        = string
  description = "Azure AD tenant id owning the Key Vault."
}

variable "soft_delete_enabled" {
  type    = bool
  default = true
}

variable "purge_protection_enabled" {
  type    = bool
  default = false
}

variable "sku_name" {
  type    = string
  default = "standard"
}

variable "public_network_access_enabled" {
  type    = bool
  default = true
}
