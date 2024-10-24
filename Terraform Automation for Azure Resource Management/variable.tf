variable "resourcegroup" {
  type = map(object({
    name        = string
    location    = string
    environment = string
    tags        = map(string)
  }))
}

variable "virtualnetworks" {
  type = map(object({
    name               = string
    location           = string
    environment        = string
    resource_group_key = string
    address_space      = list(string)
    tags               = map(string)
  }))
}

variable "subnets" {
  type = map(object({
    subnet_name         = string
    environment         = string
    resource_group_key  = string
    virtual_network_key = string
    address_prefixes    = list(string)
  }))
}

variable "networkinterfaces" {
  type = map(object({
    name               = string
    location           = string
    resource_group_key = string
    ip_configuration = object({
      name                          = string
      subnet_key                    = string
      private_ip_address_allocation = string
    })
  }))
}

variable "virtualmachines" {
  type = map(object({
    vm_environment        = string
    vm_name               = string
    vm_location           = string
    resource_group_key    = string
    network_interface_key = list(string)
    vm_size               = string
    storage_os_disk = object({
      name              = string
      caching           = string
      create_option     = string
      managed_disk_type = string
      os_disk_size_gb   = number
    })
    os_profile = object({
      computer_name  = string
      admin_username = string
      admin_password = string
      custom_data    = optional(string)
    })
    storage_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    tags = map(string)
  }))
}


































