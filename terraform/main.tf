terraform {
 required_providers {
  azurerm = {
   source = "hashicorp/azurerm"
   version = "~>3.0"
  }
 }
}

provider "azurerm" {
 features {}
}

# resource group to hold everything
resource "azurerm_resource_group" "rg" {
 name     = "capstone-rg"
 location = "New Zealand North"
}

# container registry to store docker images
resource "azurerm_container_registry" "acr" {
 name                = "capstoneacr12345"
 resource_group_name = azurerm_resource_group.rg.name
 location            = azurerm_resource_group.rg.location
 sku                 = "Basic"
 admin_enabled       = true
}

# log analytics for monitoring
resource "azurerm_log_analytics_workspace" "logs" {
 name                = "capstonelogs"
 location            = azurerm_resource_group.rg.location
 resource_group_name = azurerm_resource_group.rg.name
 sku                 = "PerGB2018"
}

# kubernetes cluster
resource "azurerm_kubernetes_cluster" "aks" {
 name                = "capstone-aks"
 location            = azurerm_resource_group.rg.location
 resource_group_name = azurerm_resource_group.rg.name
 dns_prefix          = "capstone"
 kubernetes_version  = "1.35.4"

 default_node_pool {
  name       = "default"
  node_count = 1
  vm_size    = "Standard_B2s_v2"
 }

 identity {
  type = "SystemAssigned"
 }
}
