resource "azapi_resource" "main" {
  type      = "Microsoft.VirtualMachineImages/imageTemplates@2022-02-14"
  name      = "aib-${local.resource_suffix}-${var.image_name}-${var.image_version}-${formatdate("YYYYMMDDHHmmss", timestamp())}"
  location  = azurerm_resource_group.main.location
  parent_id = azurerm_resource_group.main.id

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.main.id]
  }

  body = jsonencode({
    properties = {
      buildTimeoutInMinutes = var.build_timeout_in_minutes
      stagingResourceGroup  = azurerm_resource_group.staging.id
      vmProfile = {
        vmSize       = var.vm_size
        osDiskSizeGB = var.os_disk_size_gb
        vnetConfig = {
          proxyVmSize = var.proxy_vm_size
          subnetId    = azurerm_subnet.main.id
        }
      }
      source = {
        type      = "PlatformImage"
        publisher = var.source_image.publisher
        offer     = var.source_image.offer
        sku       = var.source_image.sku
        version   = var.source_image.version
      }
      customize = [
        {
          type = "Shell"
          name = "Update"
          inline = [
            "sudo apt-get update",
            "sudo DEBIAN_FRONTEND=noninteractive NEEDRESTART_MODE=a apt-get dist-upgrade -y"
          ]
        }
      ]
      distribute = [
        {
          type               = "SharedImage"
          galleryImageId     = "${azurerm_shared_image.main.id}/versions/${var.image_version}"
          storageAccountType = "Standard_LRS"
          runOutputName      = var.image_version
          replicationRegions = []
        }
      ]
    }
  })
}

resource "azapi_resource_action" "run" {
  type        = "Microsoft.VirtualMachineImages/imageTemplates@2022-02-14"
  resource_id = azapi_resource.main.id
  action      = "run"

  depends_on = [
    azapi_resource.main
  ]

  timeouts {
    create = "60m"
  }
}
