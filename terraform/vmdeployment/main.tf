resource "azurerm_resource_group" "practice"{
    name = var.rg
    location = var.loc
}

resource "azurerm_virtual_network" "vnet" {
  name                = "myvnet1"
  location            = var.loc
  #resource_group_name = var.rg
  /*Below line refer to implict dependecy first virtual network will wait to create resource group first 
    and then virtual network will create else both will be created simultaneously and chance to get the error*/
  resource_group_name = azurerm_resource_group.practice.name
  address_space       = var.address_space
}


resource "azurerm_subnet" "subnet" {
    name = "subnet2"
    resource_group_name = var.rg
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefix = var.subnet
}
resource "azurerm_network_interface" "vmnic" {
  name                = "vm-nic"
  location            = var.loc
  resource_group_name = var.rg

  ip_configuration {
    name = "Public"
    subnet_id = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm1" {
  name                = var.vmname
  resource_group_name = var.rg
  location            = var.loc
  size                = "Standard_DS1_v2"
  admin_username      = "adminuser"
  admin_password = "Admin@543$$"
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.vmnic.id]

  source_image_reference {
    /*publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"*/
    publisher = "OpenLogic"
    offer = "CentOs"
    sku = "7.5"
    version = "latest"
    }

    os_disk {
    name              = "vm-01-osdisk"
    caching           = "ReadWrite"
    #create_option     = "FromImage"
    #managed_disk_type = "Standard_LRS"
    storage_account_type = "Standard_LRS"
    }

    /*os_profile {
    computer_name  = "vm-01"
    admin_username = "testadmin"
    admin_password = "Password1234!"
    }*/

}
