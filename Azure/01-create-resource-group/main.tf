terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 2.0"
    }
  }
}

# Configure the Azure provider
provider "azurerm" {
    subscription_id = var.subscription_id
    features {}
}

# Create a new resource group
resource "azurerm_resource_group" "rg" {
    name     = var.rg_name
    location = var.region

    tags = {
        Enviroment = "Terraform getting started"
        Team = "DevOps"
    }
}