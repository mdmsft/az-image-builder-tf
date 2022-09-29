resource "azurerm_resource_group" "main" {
  name     = "rg-${local.resource_suffix}"
  location = var.location.name
}

resource "azurerm_resource_group" "staging" {
  name     = "rg-${local.resource_suffix}-stg"
  location = var.location.name

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

data "azurerm_client_config" "main" {}
