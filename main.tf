# Configure the Azure Provider
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=2.0.0"
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "asp-net-api" {
  name     = "asp-net-api"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "asp-net-api" {
  name                = "asp-net-api-serviceplan"
  location            = azurerm_resource_group.asp-net-api.location
  resource_group_name = azurerm_resource_group.asp-net-api.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "asp-net-api" {
  name                = "asp-net-api-service"
  location            = azurerm_resource_group.asp-net-api.location
  resource_group_name = azurerm_resource_group.asp-net-api.name
  app_service_plan_id = azurerm_app_service_plan.asp-net-api.id
}

resource "azurerm_app_service_slot" "asp-net-api-staging" {
  name                = "staging"
  location            = azurerm_resource_group.asp-net-api.location
  resource_group_name = azurerm_resource_group.asp-net-api.name
  app_service_plan_id = azurerm_app_service_plan.asp-net-api.id
  app_service_name    = azurerm_app_service.asp-net-api.name
}


