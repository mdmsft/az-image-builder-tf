variable "project" {
  type    = string
  default = "contoso"
}

variable "location" {
  type = object({
    name = string
    code = string
  })
  default = {
    name = "westeurope"
    code = "weu"
  }
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "tenant_id" {
  type = string
}

variable "subscription_id" {
  type = string
}

variable "network_address_space" {
  type = string
}

variable "image_name" {
  type = string
}

variable "image_version" {
  type = string
}

variable "image_os_type" {
  type = string
}

variable "image_architecture" {
  type = string
}

variable "image_generation" {
  type = string
}

variable "image_trusted_launch_enabled" {
  type = bool
}

variable "image_accelerated_network_support_enabled" {
  type = bool
}

variable "build_timeout_in_minutes" {
  type = number
}

variable "vm_size" {
  type = string
}

variable "os_disk_size_gb" {
  type = number
}

variable "proxy_vm_size" {
  type = string
}

variable "source_image" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}
