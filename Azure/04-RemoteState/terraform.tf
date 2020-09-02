terraform {
    backend "azurerm" {
    resource_group_name     = "rs-admin"
    storage_account_name    = "turnesadmin"
    container_name          = "terraformstate"
    key                     = "04-remotestate"
  }
}