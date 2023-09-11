provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "aks" {
  name     = "my-aks-rg"
  location = "eastus"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "my-aks-cluster"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = "myakscluster"

  linux_profile {
    admin_username = "azureuser"

    ssh_key {
      key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7..."
    }
  }

  agent_pool_profile {
    name            = "default"
    count           = 3
    vm_size         = "Standard_D2_v2"
    os_type         = "Linux"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = "7f6c5d9d-4b5d-4c1e-9d1a-8d7b8b9a8c5e"
    client_secret = "7f6c5d9d-4b5d-4c1e-9d1a-8d7b8b9a8c5e"
  }

  tags = {
    Environment = "Dev"
  }
}
