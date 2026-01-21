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

module "compute" {
  source = "../../modules/compute"

  resource_group_name   = module.network.resource_group_name
  location              = module.network.location
  vm_name               = "${var.name_prefix}-${var.environment}-vm01"
  vm_size               = "Standard_B1ms"
  subnet_id             = module.network.subnet_id
  admin_username        = "azureadmin"
  admin_ssh_public_key  = file("~/.ssh/id_rsa.pub") # or pass via var in CI
  create_public_ip      = false
  os_disk_size_gb       = 30
}

module "keyvault" {
  source              = "../../modules/keyvault"
  resource_group_name = module.network.resource_group_name
  location            = module.network.location
  key_vault_name      = "${var.name_prefix}-${var.environment}-kv"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  # adjust defaults via variables as needed
}
data "azurerm_client_config" "current" {}

resource "random_uuid" "vm_kv_role_uuid" {}

resource "azurerm_role_assignment" "vm_kv_secret_user" {
  name               = random_uuid.vm_kv_role_uuid.result
  scope              = module.keyvault.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id       = module.compute.identity_principal_id

  # ensure compute module is created before the role assignment
  depends_on = [module.compute, module.keyvault]
}
