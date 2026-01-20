locals {
  rg_name    = "${var.name_prefix}-${var.environment}-rg"
  vnet_name  = "${var.name_prefix}-${var.environment}-vnet"
  subnet_name = "${var.name_prefix}-${var.environment}-subnet"
}

module "network" {
  source = "../../modules/network"

  location              = var.location
  resource_group_name   = local.rg_name
  vnet_name             = local.vnet_name
  subnet_name           = local.subnet_name
  vnet_address_space    = var.vnet_address_space
  subnet_address_prefixes = var.subnet_address_prefixes
}
