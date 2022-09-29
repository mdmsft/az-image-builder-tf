network_address_space                     = "192.168.255.0/24"
image_name                                = "adventure-works"
image_version                             = "1.0.0"
image_os_type                             = "Linux"
image_architecture                        = "x64"
image_generation                          = "V2"
image_trusted_launch_enabled              = true
image_accelerated_network_support_enabled = true
build_timeout_in_minutes                  = 60
vm_size                                   = "Standard_D2_v5"
os_disk_size_gb                           = 64
proxy_vm_size                             = "Standard_D8_v5"
source_image = {
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-server-jammy"
  sku       = "22_04-lts-gen2"
  version   = "latest"
}
