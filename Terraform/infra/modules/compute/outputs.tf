output "vm_id" {
  value = azurerm_linux_virtual_machine.vm.id
}

output "vm_private_ip" {
  value = azurerm_network_interface.nic.ip_configuration[0].private_ip_address
}

output "nic_id" {
  value = azurerm_network_interface.nic.id
}

output "public_ip_address" {
  value = var.create_public_ip ? azurerm_public_ip.pip[0].ip_address : ""
  description = "Public IP address (empty string if create_public_ip = false)."
}

output "identity_principal_id" {
  value = azurerm_linux_virtual_machine.vm.identity[0].principal_id
  description = "Principal (object) id for the system assigned managed identity."
}
