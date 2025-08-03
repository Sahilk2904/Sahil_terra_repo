resource "azurerm_resource_group" "sahilrg" {
  name     = "sahilrgt1"
  location = "West US"
}
resource "azurerm_storage_account" "sahilstg1" {
  name                     = "sahilstg12"
  resource_group_name      = azurerm_resource_group.sahilrg.name
  location                 = azurerm_resource_group.sahilrg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  depends_on               = [azurerm_resource_group.sahilrg]
}
resource "azurerm_virtual_network" "sahilvnet" {
  name                = "schugvnet1"
  resource_group_name = azurerm_resource_group.sahilrg.name
  location            = azurerm_resource_group.sahilrg.location
  address_space       = ["10.0.0.0/16"]
  depends_on          = [azurerm_resource_group.sahilrg]
}
resource "azurerm_subnet" "sahilsubnet" {
  name                 = "ssubnet"
  resource_group_name  = azurerm_resource_group.sahilrg.name
  address_prefixes     = ["10.0.0.0/28"]
  virtual_network_name = azurerm_virtual_network.sahilvnet.name
  depends_on           = [azurerm_resource_group.sahilrg]
}
resource "azurerm_public_ip" "sahilpuip" {
  name                = "sapublicip"
  resource_group_name = azurerm_resource_group.sahilrg.name
  location            = azurerm_resource_group.sahilrg.location
  allocation_method   = "Static"
  depends_on          = [azurerm_resource_group.sahilrg]
}
resource "azurerm_network_interface" "sahilnic" {
  name                = "nic"
  resource_group_name = azurerm_resource_group.sahilrg.name
  location            = azurerm_resource_group.sahilrg.location
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.sahilsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.sahilpuip.id
  }
}
resource "azurerm_linux_virtual_machine" "sahilvm" {
  name                            = "vm2"
  resource_group_name             = azurerm_resource_group.sahilrg.name
  location                        = azurerm_resource_group.sahilrg.location
  size                            = "Standard_F2"
  admin_username                  = "sahilchug12"
  admin_password                  = "admin@123"
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.sahilnic.id]
  # admin_ssh_key{
  #   username = "adminuser"
  #   public_key = file("/.ssh/id_rsa.pub")
  # }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

}