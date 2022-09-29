terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~>2.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~>1.0"
    }
  }
  backend "azurerm" {
    container_name   = "tfstate"
    key              = "aib"
    use_azuread_auth = true
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

provider "azuread" {
  tenant_id = var.tenant_id
}
