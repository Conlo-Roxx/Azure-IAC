resource "azurerm_key_vault" "kv" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = var.tenant_id
  sku_name                    = var.sku_name

  # Enable role-based access control for data plane operations (secrets/keys/certs)
  rbac_authorization_enabled  = true

  # Safety features (adjust as needed)
   purge_protection_enabled    = var.purge_protection_enabled

  # Networking: leaving public access enabled by default; lock this down later if you need
  public_network_access_enabled = var.public_network_access_enabled

  tags = {
    managed_by = "terraform"
    module     = "keyvault"
  }
}
