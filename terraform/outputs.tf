output "vm_ids" {
  description = "Resource IDs of all provisioned virtual machines."
  value       = azurerm_linux_virtual_machine.build_vm[*].id
}

output "vm_names" {
  description = "Names of all provisioned virtual machines."
  value       = azurerm_linux_virtual_machine.build_vm[*].name
}

output "vm_private_ips" {
  description = "Private IP addresses assigned to each virtual machine."
  value       = azurerm_network_interface.build_nic[*].private_ip_address
}
