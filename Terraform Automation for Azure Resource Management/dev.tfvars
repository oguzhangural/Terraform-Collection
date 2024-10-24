resourcegroup = {
  rg1 = {
    name        = "my-task01"
    location    = "WestEurope"
    environment = "dev"
    tags = {
      environment = "dev"
    }
  },
  rg2 = {
    name        = "my-task02"
    location    = "NorthEurope"
    environment = "dev"
    tags = {
      environment = "dev"
    }
  },
}

virtualnetworks = {
  v1 = {
    name               = "vnet-01"
    location           = "WestEurope"
    environment        = "dev"
    resource_group_key = "rg1"
    address_space      = ["10.0.0.0/24", "10.0.1.0/24"]
    tags = {
      environment = "dev"
    }
  },
  v2 = {
    name               = "vnet-02"
    location           = "NorthEurope"
    environment        = "dev"
    resource_group_key = "rg2"
    address_space      = ["20.0.0.0/24", "20.0.1.0/24"]
    tags = {
      environment = "dev"
    }
  }
}

subnets = {
  s1 = {
    subnet_name         = "sbnt01"
    environment         = "dev"
    resource_group_key  = "rg1"
    virtual_network_key = "v1"
    address_prefixes    = ["10.0.0.0/28"]
  },
  s2 = {
    subnet_name         = "sbnt01"
    environment         = "dev"
    resource_group_key  = "rg2"
    virtual_network_key = "v2"
    address_prefixes    = ["20.0.0.0/28"]
  }
}

networkinterfaces = {
  n1 = {
    name               = "nic01"
    location           = "WestEurope"
    resource_group_key = "rg1"
    ip_configuration = {
      name                          = "ipconfig01"
      subnet_key                    = "s1"
      private_ip_address_allocation = "Dynamic"
    }
  }
}

virtualmachines = {
  vm1 = {
    vm_environment        = "dev"
    vm_name               = "my-vm01"
    vm_location           = "WestEurope"
    resource_group_key    = "rg1"
    network_interface_key = ["n1"]
    vm_size               = "Standard_DS1_v2"
    storage_os_disk = {
      name              = "myosdisk1"
      caching           = "ReadWrite"
      create_option     = "FromImage"
      managed_disk_type = "Standard_LRS"
      os_disk_size_gb   = 127 # veya daha büyük bir değer
    }
    os_profile = {
      computer_name  = "my-vm01"
      admin_username = "Azure.Azure.Azure"
      admin_password = "Password1234!"
      custom_data    = ""
    }
    storage_image_reference = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2016-Datacenter"
      version   = "latest"
    }
    tags = {
      environment = "dev"
    }
  }
}













