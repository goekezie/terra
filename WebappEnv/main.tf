provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "tailspin-space-game-rg"
  location = "westus2"
}

resource "azurerm_app_service_plan" "example" {
  count               = 2
  name                = element(var.app_service_plan_name, count.index)
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Standard"
    size = element(var.sku, count.index)
  }
}

resource "azurerm_app_service" "example" {  
  name                = var.app_service_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.example.id
}