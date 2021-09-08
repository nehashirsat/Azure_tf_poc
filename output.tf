output "Public_ip_of_vm" {
  value = azurerm_public_ip.public_ip.ip_address
}