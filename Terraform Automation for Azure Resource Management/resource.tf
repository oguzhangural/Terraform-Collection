resource "azurerm_resource_group" "rsgrp" {
  for_each = var.resourcegroup
  name     = "${each.value.environment}-${each.value.name}"
  location = each.value.location
  tags     = each.value.tags
}

resource "azurerm_virtual_network" "vnet" {
  for_each            = var.virtualnetworks
  name                = "${each.value.environment}-${each.value.name}"
  location            = each.value.location
  resource_group_name = azurerm_resource_group.rsgrp[each.value.resource_group_key].name
  address_space       = each.value.address_space
  tags                = each.value.tags
}

resource "azurerm_subnet" "sbnt" {
  for_each             = var.subnets
  name                 = "${each.value.environment}-${each.value.subnet_name}"
  resource_group_name  = azurerm_resource_group.rsgrp[each.value.resource_group_key].name
  virtual_network_name = azurerm_virtual_network.vnet[each.value.virtual_network_key].name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_network_interface" "nic" {
  for_each            = var.networkinterfaces
  name                = each.value.name
  location            = each.value.location
  resource_group_name = azurerm_resource_group.rsgrp[each.value.resource_group_key].name
  ip_configuration {
    name                          = each.value.ip_configuration.name
    subnet_id                     = azurerm_subnet.sbnt[each.value.ip_configuration.subnet_key].id
    private_ip_address_allocation = each.value.ip_configuration.private_ip_address_allocation
  }
}

resource "azurerm_virtual_machine" "vm" {
  for_each = var.virtualmachines
  name                  = "${each.value.vm_environment}-${each.value.vm_name}"
  location              = each.value.vm_location
  resource_group_name   = azurerm_resource_group.rsgrp[each.value.resource_group_key].name
  network_interface_ids = [azurerm_network_interface.nic[each.value.network_interface_key[0]].id]
  vm_size               = each.value.vm_size
  storage_image_reference {
    publisher = each.value.storage_image_reference.publisher
    offer     = each.value.storage_image_reference.offer
    sku       = each.value.storage_image_reference.sku
    version   = each.value.storage_image_reference.version
  }
  storage_os_disk {
    name              = each.value.storage_os_disk.name
    caching           = each.value.storage_os_disk.caching
    create_option     = each.value.storage_os_disk.create_option
    managed_disk_type = each.value.storage_os_disk.managed_disk_type
    disk_size_gb      = each.value.storage_os_disk.os_disk_size_gb
  }
  os_profile {
    computer_name  = each.value.os_profile.computer_name
    admin_username = each.value.os_profile.admin_username
    admin_password = each.value.os_profile.admin_password
    custom_data    = each.value.os_profile.custom_data
  }
  os_profile_windows_config {
    provision_vm_agent = true
  }
  tags = each.value.tags
}


































