resource "azurerm_linux_virtual_machine" "example" {
  depends_on = [azurerm_mysql_server.mysql_server]
  name                = "${var.prefix}-machine"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  size                = "Standard_DS1_v2"
  admin_username      = "adminuser"
  network_interface_ids = [azurerm_network_interface.main.id]
  custom_data    = filebase64("azure_user_data.sh")
  
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("Azure_key.pub")
  } 

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  provisioner "local-exec" {
    command = "echo ${azurerm_mysql_server.mysql_server.fqdn} ${azurerm_mysql_server.mysql_server.administrator_login}@${azurerm_mysql_server.mysql_server.name} > dbdetails.txt"
  }
}
resource "azurerm_public_ip" "linux_vm_public_ip" {
  #depends_on=[azurerm_resource_group.resource_group]
  name                = "${var.prefix}-linuxvm-public_ip"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  allocation_method   = "Dynamic"
  sku = "Basic"
  tags = {
    environment = var.environment
  }
}