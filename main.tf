terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.32.0"
    }
  }
}


#Resource group (rg-networking-prod-s-01) in the UK South region 
resource "azurerm_resource_group" "rg-networking-prod-s-01" {
  name     = "rg-networking-prod-s-01"
  location = "UK South"
  tags = var.tags
}

#Resource group (rg-networking-prod-w-01) in the UK West region
resource "azurerm_resource_group" "rg-networking-prod-w-01" {
  name     = "rg-networking-prod-w-01"
  location = "UK West"
  tags = var.tags
}

#Virtual network (vnet-networking-prod-s-01) in the UK South region
resource "azurerm_virtual_network" "vnet-networking-prod-s-01" {
  name                = "vnet-networking-prod-s-01"
  location            = azurerm_resource_group.rg-networking-prod-s-01.location
  resource_group_name = azurerm_resource_group.rg-networking-prod-s-01.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "subnet-networking-prod-s-01"
    address_prefix = "10.0.1.0/24"
    #service_endpoints = "Microsoft.KeyVault"
  }

  tags = var.tags
}

#Virtual network (vnet-networking-prod-w-01) in the UK West region
resource "azurerm_virtual_network" "vnet-networking-prod-w-01" {
  name                = "vnet-networking-prod-w-01"
  location            = azurerm_resource_group.rg-networking-prod-w-01.location
  resource_group_name = azurerm_resource_group.rg-networking-prod-w-01.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
  
  subnet {
    name           = "subnet-networking-prod-w-01"
    address_prefix = "10.0.1.0/24"
    #service_endpoints = "Microsoft.KeyVault"
  }

  tags = var.tags
}

#Route table (udr-networking-prod-s-01) in the UK South region
resource "azurerm_route_table" "udr-networking-prod-s-01" {
  name                          = "udr-networking-prod-s-01"
  location                      = azurerm_resource_group.rg-networking-prod-s-01.location
  resource_group_name           = azurerm_resource_group.rg-networking-prod-s-01.name
   #disable_bgp_route_propagation = false

  route {
    name           = "route-s-1"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "VirtualAppliance"
  }

  tags = var.tags
  
}

#route table (udr-networking-prod-w-01) in the UK West region
resource "azurerm_route_table" "udr-networking-prod-w-01" {
  name                          = "udr-networking-prod-w-01"
  location                      = azurerm_resource_group.rg-networking-prod-w-01.location
  resource_group_name           = azurerm_resource_group.rg-networking-prod-w-01.name
   #disable_bgp_route_propagation = false

  route {
    name           = "route-w-1"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "VirtualAppliance"
  }

  tags = var.tags
  
}

#network security group (nsg-networking-prod-s-01) in the UK South region
resource "azurerm_network_security_group" "nsg-networking-prod-s-01" {
  name                = "acceptanceTestSecurityGroup1"
  location            = azurerm_resource_group.rg-networking-prod-s-01.location
  resource_group_name = azurerm_resource_group.rg-networking-prod-s-01.name

  #security_rule {
    #name                       = "AllowVnetInBound"
    #priority                   = 65000
    #direction                  = "Inbound"
    #access                     = "Allow"
    #protocol                   = "*"
    #source_port_range          = "*"
    #destination_port_range     = "*"
    #source_address_prefix      = "*"
    #destination_address_prefix = "*"
  #}

  #security_rule {
    #name                       = "AllowAzureLoadBalancerInBound"
    #priority                   = 65001
    #direction                  = "Inbound"
    #access                     = "Allow"
    #protocol                   = "*"
    #source_port_range          = "*"
    #destination_port_range     = "*"
    #source_address_prefix      = "*"
    #destination_address_prefix = "*"
  #}

  #security_rule {
    #name                       = "DenyAllInBound"
    #priority                   = 65500
    #direction                  = "Inbound"
    #access                     = "Deny"
    #protocol                   = "*"
    #source_port_range          = "*"
    #destination_port_range     = "*"
    #source_address_prefix      = "*"
    #destination_address_prefix = "*"
  #}

  #security_rule {
    #name                       = "AzureCloud"
    #priority                   = 2480
    #direction                  = "Outbound"
    #access                     = "Allow"
    #protocol                   = "TCP"
    #source_port_range          = "*"
    #destination_port_range     = "*"
    #source_address_prefix      = "*"
    #destination_address_prefix = "*"
  #}

  #security_rule {
    #name                       = "WVDService"
    #priority                   = 2490
    #direction                  = "Outbound"
    #access                     = "Allow"
    #protocol                   = "Tcp"
    #source_port_range          = "*"
    #destination_port_range     = "*"
    #source_address_prefix      = "*"
    #destination_address_prefix = "*"
  #}

  #security_rule {
    #name                       = "KMS"
    #priority                   = 2500
    #direction                  = "Outbound"
    #access                     = "Allow"
    #protocol                   = "Tcp"
    #source_port_range          = "*"
    #destination_port_range     = "*"
    #source_address_prefix      = "*"
    #destination_address_prefix = "*"
  #}  

  #security_rule {
    #name                       = "TimeService"
    #priority                   = 2501
    #direction                  = "Outbound"
    #access                     = "Allow"
    #protocol                   = "Tcp"
    #source_port_range          = "*"
    #destination_port_range     = "*"
    #source_address_prefix      = "*"
    #destination_address_prefix = "*"
  #}  

  #security_rule {
    #name                       = "AllowVnetOutBound"
    #priority                   = 65000
    #direction                  = "Outbound"
    #access                     = "Allow"
    #protocol                   = "*"
    #source_port_range          = "*"
    #destination_port_range     = "*"
    #source_address_prefix      = "*"
    #destination_address_prefix = "*"
  #}  

  #security_rule {
    #name                       = "AllowInternetOutBound"
    #priority                   = 65001
    #direction                  = "Outbound"
    #access                     = "Allow"
    #protocol                   = "*"
    #source_port_range          = "*"
    #destination_port_range     = "*"
    #source_address_prefix      = "*"
    #destination_address_prefix = "*"
  #}  

  #security_rule {
    #name                       = "DenyAllOutBound"
    #priority                   = 65500
    #direction                  = "Outbound"
    #access                     = "Deny"
    #protocol                   = "*"
    #source_port_range          = "*"
    #destination_port_range     = "*"
    #source_address_prefix      = "*"
    #destination_address_prefix = "*"
  #}  

  tags = var.tags
}

#network security group (nsg-networking-prod-w-01) in the UK West region
resource "azurerm_network_security_group" "nsg-networking-prod-w-01" {
  name                = "acceptanceTestSecurityGroup1"
  location            = azurerm_resource_group.rg-networking-prod-w-01.location
  resource_group_name = azurerm_resource_group.rg-networking-prod-w-01.name

  #security_rule {
    #name                       = "AllowVnetInBound"
    #priority                   = 65000
    #direction                  = "Inbound"
    #access                     = "Allow"
    #protocol                   = "*"
    #source_port_range          = "*"
    #destination_port_range     = "*"
    #source_address_prefix      = "*"
    #destination_address_prefix = "*"
  #}

  #security_rule {
    #name                       = "AllowAzureLoadBalancerInBound"
    #priority                   = 65001
    #direction                  = "Inbound"
    #access                     = "Allow"
    #protocol                   = "*"
    #source_port_range          = "*"
    #destination_port_range     = "*"
    #source_address_prefix      = "*"
    #destination_address_prefix = "*"
  #}

  #security_rule {
    #name                       = "DenyAllInBound"
    #priority                   = 65500
    #direction                  = "Inbound"
    #access                     = "Deny"
    #protocol                   = "*"
    #source_port_range          = "*"
    #destination_port_range     = "*"
    #source_address_prefix      = "*"
    #destination_address_prefix = "*"
  #}

  #security_rule {
    #name                       = "AzureCloud"
    #priority                   = 2480
    #direction                  = "Outbound"
    #access                     = "Allow"
    #protocol                   = "TCP"
    #source_port_range          = "*"
    #destination_port_range     = "*"
    #source_address_prefix      = "*"
    #destination_address_prefix = "*"
  #}

  #security_rule {
    #name                       = "WVDService"
    #priority                   = 2490
    #direction                  = "Outbound"
    #access                     = "Allow"
    #protocol                   = "Tcp"
    #source_port_range          = "*"
    #destination_port_range     = "*"
    #source_address_prefix      = "*"
    #destination_address_prefix = "*"
  #}

  #security_rule {
    #name                       = "KMS"
    #priority                   = 2500
    #direction                  = "Outbound"
    #access                     = "Allow"
    #protocol                   = "Tcp"
    #source_port_range          = "*"
    #destination_port_range     = "*"
    #source_address_prefix      = "*"
    #destination_address_prefix = "*"
  #}  

  #security_rule {
    #name                       = "TimeService"
    #priority                   = 2501
    #direction                  = "Outbound"
    #access                     = "Allow"
    #protocol                   = "Tcp"
    #source_port_range          = "*"
    #destination_port_range     = "*"
    #source_address_prefix      = "*"
    #destination_address_prefix = "*"
  #}  

  #security_rule {
    #name                       = "AllowVnetOutBound"
    #priority                   = 65000
    #direction                  = "Outbound"
    #access                     = "Allow"
    #protocol                   = "*"
    #source_port_range          = "*"
    #destination_port_range     = "*"
    #source_address_prefix      = "*"
    #destination_address_prefix = "*"
  #}  

  #security_rule {
    #name                       = "AllowInternetOutBound"
    #priority                   = 65001
    #direction                  = "Outbound"
    #access                     = "Allow"
    #protocol                   = "*"
    #source_port_range          = "*"
    #destination_port_range     = "*"
    #source_address_prefix      = "*"
    #destination_address_prefix = "*"
  #}  

  #security_rule {
    #name                       = "DenyAllOutBound"
    #priority                   = 65500
    #direction                  = "Outbound"
    #access                     = "Deny"
    #protocol                   = "*"
    #source_port_range          = "*"
    #destination_port_range     = "*"
    #source_address_prefix      = "*"
    #destination_address_prefix = "*"
  #}  

  tags = var.tags
}

#Azure Bastion in the UK South region
resource "azurerm_public_ip" "pip-networking-prod-s-01" {
  name                = "pip-networking-prod-s-01"
  location            = azurerm_resource_group.rg-networking-prod-s-01.location
  resource_group_name = azurerm_resource_group.rg-networking-prod-s-01.name
  allocation_method   = "Static"
  sku                 = "Standard"
}
resource "azurerm_bastion_host" "bh-networking-prod-s-01" {
  name                = "bh-networking-prod-s-01"
  location            = azurerm_resource_group.rg-networking-prod-s-01.location
  resource_group_name = azurerm_resource_group.rg-networking-prod-s-01.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.subnet-networking-prod-s-01.id
    public_ip_address_id = azurerm_public_ip.pip-networking-prod-s-01.id
  }
}

#Azure Bastion in the UK West region
resource "azurerm_public_ip" "pip-networking-prod-w-01" {
  name                = "pip-networking-prod-w-01"
  location            = azurerm_resource_group.rg-networking-prod-w-01.location
  resource_group_name = azurerm_resource_group.rg-networking-prod-w-01.name
  allocation_method   = "Static"
  sku                 = "Standard"
}
resource "azurerm_bastion_host" "bh-networking-prod-w-01" {
  name                = "bh-networking-prod-s-01"
  location            = azurerm_resource_group.rg-networking-prod-w-01.location
  resource_group_name = azurerm_resource_group.rg-networking-prod-w-01.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.subnet-networking-prod-w-01.id
    public_ip_address_id = azurerm_public_ip.pip-networking-prod-w-01.id
  }
}

#key vault (kv-networking-prod-s-01) in the UK South region
resource "azurerm_key_vault" "kv-networking-prod-s-01" {
  name                        = "kv-networking-prod-s-01"
  location                    = azurerm_resource_group.rg-networking-prod-s-01.location
  resource_group_name         = azurerm_resource_group.rg-networking-prod-s-01.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current-networking-s-01.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current-networking-s-01.tenant_id
    object_id = data.azurerm_client_config.current-networking-s-01.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}

#key vault (kv-networking-prod-w-01) in the UK West region 
resource "azurerm_key_vault" "kv-networking-prod-w-01" {
  name                        = "kv-networking-prod-w-01"
  location                    = azurerm_resource_group.rg-networking-prod-w-01.location
  resource_group_name         = azurerm_resource_group.rg-networking-prod-w-01.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current-networking-w-01.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current-networking-w-01.tenant_id
    object_id = data.azurerm_client_config.current-networking-w-01.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}






#Block Definitions
resource "azurerm_subnet" "subnet-networking-prod-w-01" {
    name           = "subnet-networking-prod-w-01"
    resource_group_name = azurerm_resource_group.rg-networking-prod-w-01.name
    virtual_network_name = "vnet-networking-prod-w-01"
    address_prefixes = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "subnet-networking-prod-s-01" {
    name           = "subnet-networking-prod-s-01"
    resource_group_name = azurerm_resource_group.rg-networking-prod-s-01.name
    virtual_network_name = "vnet-networking-prod-s-01"
    address_prefixes = ["10.0.1.0/24"]
}

data "azurerm_client_config" "current-networking-s-01" {
  #name = "current-networking-s-01"
}

data "azurerm_client_config" "current-networking-w-01" {
  #name = "current-networking-w-01"
}