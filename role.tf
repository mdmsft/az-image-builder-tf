resource "azurerm_role_definition" "main" {
  name  = "Image Builder"
  scope = "/subscriptions/${data.azurerm_client_config.main.subscription_id}"

  permissions {
    actions = [
      "Microsoft.Compute/galleries/read",
      "Microsoft.Compute/galleries/images/read",
      "Microsoft.Compute/galleries/images/versions/read",
      "Microsoft.Compute/galleries/images/versions/write",
      "Microsoft.Compute/images/write",
      "Microsoft.Compute/images/read",
      "Microsoft.Compute/images/delete",
    ]
  }
}
