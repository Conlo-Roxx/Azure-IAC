variable "resource_group_name" {
  type        = string
  description = "Resource group where VM and NIC will be created."
}

variable "location" {
  type        = string
  description = "Azure region for resources."
}

variable "vm_name" {
  type        = string
  description = "Base name for the virtual machine."
}

variable "vm_size" {
  type        = string
  description = "Azure VM size."
  default     = "Standard_B1s"
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet to attach the NIC to."
}

variable "admin_username" {
  type        = string
  description = "Admin username for the Linux VM."
  default     = "azureadmin"
}

variable "admin_ssh_public_key" {
  type        = string
  description = "Public SSH key (openssh format) for the admin user. Recommended to use."
}

variable "create_public_ip" {
  type        = bool
  description = "Whether to create and attach a Public IP to the NIC."
  default     = false
}

variable "os_disk_size_gb" {
  type        = number
  description = "OS disk size in GB."
  default     = 30
}

variable "image_publisher" {
  type    = string
  default = "Canonical"
}

variable "image_offer" {
  type    = string
  default = "UbuntuServer"
}

variable "image_sku" {
  type    = string
  default = "22_04-lts" # or "20_04-lts" depending on preference
}

variable "image_version" {
  type    = string
  default = "latest"
}
