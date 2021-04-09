provider "azurerm" {
  features {}
}


variable "app_service_plan_name" {
  description = "The name used to identify the app service"
  
}

variable "app_service_plan_name_con" {
  description = "The name used to identify the app service"
  
}

variable "sku_size" {
  description = "The sku size"
  
}

variable "sku_tier" {
  description = "The sku tier"

}

variable "storage_account_name" {
  description = "The name used to identify the storage account"

}

variable "storage_account_tier" {
  description = "The name used to identify the tier of the storage account"

}

variable "app_service_name" {
  description = "The name used to identify the app service"

}

variable "function_app_name" {
  description = "The name used to identify the function app"

}

variable "resource_group_name" {
  description = "The name used to identify the resource group"

}

variable "resource_group_location" {
  description = "The name used to identify the location of the resource group"

}

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_storage_account" "example" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = var.storage_account_tier
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "example" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  sku {
    tier = var.sku_tier
    size = var.sku_size
  }
}

resource "azurerm_app_service" "example" {
#   count               = 2  
  name                = var.app_service_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id

}

resource "azurerm_app_service_plan" "consumption" {
  name                = var.app_service_plan_name_con
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "example" {
  name                       = var.function_app_name
  location                   = azurerm_resource_group.example.location
  resource_group_name        = azurerm_resource_group.example.name
  app_service_plan_id        = azurerm_app_service_plan.consumption.id
  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
  version                    = 3
}


