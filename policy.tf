data "azurerm_policy_definition" "main" {
  display_name = "VM Image Builder templates should use private link"
}

resource "azurerm_resource_group_policy_assignment" "main" {
  name                 = "VM Image Builder templates should use private link"
  policy_definition_id = data.azurerm_policy_definition.main.id
  resource_group_id    = azurerm_resource_group.main.id
}
