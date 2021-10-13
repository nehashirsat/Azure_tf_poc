output "Public_ip_of_vm" {
  value = azurerm_public_ip.public_ip.ip_address
}

output "mysql_endpoint" {
  value = azurerm_mysql_server.mysql_server.fqdn
}

output "mysql_id" {
  value = azurerm_mysql_server.mysql_server.id
}

#Output For User Id
output "mysql_user_login_id" {
  value = "${azurerm_mysql_server.mysql_server.administrator_login}@${azurerm_mysql_server.mysql_server.name}"
}
