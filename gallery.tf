resource "azurerm_shared_image_gallery" "main" {
  name                = "sig${replace(local.resource_suffix, "-", "")}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
}

resource "azurerm_shared_image" "main" {
  name                                = var.image_name
  resource_group_name                 = azurerm_resource_group.main.name
  location                            = azurerm_resource_group.main.location
  gallery_name                        = azurerm_shared_image_gallery.main.name
  os_type                             = var.image_os_type
  architecture                        = var.image_architecture
  hyper_v_generation                  = var.image_generation
  trusted_launch_enabled              = var.image_trusted_launch_enabled
  accelerated_network_support_enabled = var.image_accelerated_network_support_enabled

  identifier {
    publisher = var.source_image.publisher
    offer     = var.source_image.offer
    sku       = var.source_image.sku
  }
}
