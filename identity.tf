resource "azurerm_user_assigned_identity" "main" {
  name                = "id-${local.resource_suffix}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
}

resource "azurerm_role_assignment" "image_builder" {
  role_definition_id = azurerm_role_definition.main.role_definition_resource_id
  principal_id       = azurerm_user_assigned_identity.main.principal_id
  scope              = azurerm_resource_group.main.id
}

resource "azurerm_role_assignment" "contributor" {
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.main.principal_id
  scope                = azurerm_resource_group.staging.id
}
