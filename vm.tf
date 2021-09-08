/*locals {
  custom_data = <<CUSTOM_DATA
  #! /bin/bash
  sudo apt update
  sudo apt install python3-pip -y
  git clone https://github.com/nehashirsat/linuxos.git
  cd linuxos
  pip3 install -r requirements.txt
  sudo python3 app.py
  CUSTOM_DATA
  }
*/

resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.prefix}-vm"
  location              = azurerm_resource_group.resource_group.location
  resource_group_name   = azurerm_resource_group.resource_group.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_DS1_v2"

  #  delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "StandardSSD_LRS"
  }
  os_profile {
    computer_name  = "${var.prefix}-vm"
    admin_username = "adminuser"
    admin_password = "adminuser@123"
    #custom_data = base64encode(local.custom_data)
    custom_data    = file("azure_user_data.sh")
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = var.environment
  }
}

resource "azurerm_public_ip" "public_ip" {
  depends_on=[azurerm_resource_group.resource_group]
  name                = "${var.prefix}-vm-public_ip"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  allocation_method   = "Dynamic"
  sku = "Basic"
  tags = {
    environment = var.environment
  }
}