
provider "azurerm" {
  features {}
}


data "azurerm_resource_group" "example" {
  name = "containers"
}

output "id" {
  value = data.azurerm_resource_group.example.id
}
output "location" {
  value = data.azurerm_resource_group.example.location
}



resource "azurerm_storage_account" "example" {
  name                     = "containerkez"
  resource_group_name      = data.azurerm_resource_group.example.name
  location                 = data.azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_sql_server" "example" {
  name                         = "kezsqlserver"
  resource_group_name          = data.azurerm_resource_group.example.name
  location                     = data.azurerm_resource_group.example.location
  version                      = "12.0"
  administrator_login          = "Admin1234567"
  administrator_login_password = "Admin@1234567"
}

resource "azurerm_mssql_database" "example" {
  name           = "kez-db-d"
  server_id      = azurerm_sql_server.example.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 4
  read_scale     = true
  sku_name       = "BC_Gen5_2"
  zone_redundant = true

  extended_auditing_policy {
    storage_endpoint                        = azurerm_storage_account.example.primary_blob_endpoint
    storage_account_access_key              = azurerm_storage_account.example.primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 6
  }


}
