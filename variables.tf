variable "azure_region" {
  description = "The Azure region to deploy the resources."
  type        = string
  default     = "westus2"
}
variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "matti-vnet"
}

variable "vnet_name1" {
  description = "The name of the first virtual network."
  type        = string
  default     = "matti-vnet1"
}

variable "vnet_name2" {
  description = "The name of the second virtual network."
  type        = string
  default     = "matti-vnet2"
}

variable "vnet_subnet1" {
  description = "The name of the first virtual network subnet"
  type        = string
  default     = "subnet-1"
}

variable "vnet_subnet2" {
  description = "The name of the second virtual network subnet"
  type        = string
  default     = "subnet-2"
}

variable "vnet1_address_space" {
  description = "The address space of the first virtual network."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "vnet2_address_space" {
  description = "The address space of the second virtual network."
  type        = list(string)
  default     = ["10.1.0.0/16"]
}

variable "vnet1_subnet_address_prefix" {
  description = "The subnet prefix address for first virtual network"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "vnet2_subnet_address_prefix" {
  description = "The subnet prefix address for second virtual network"
  type        = list(string)
  default     = ["10.1.3.0/24"]
}

variable "vnet1_nic" {
  description = "The name of virtual network network interface controller"
  type        = string
  default     = "matti-vnet1-nic"
}

variable "vnet2_nic" {
  description = "The name of virtual network network interface controller"
  type        = string
  default     = "matti-vnet2-nic"
}

variable "vnet1_vm" {
  description = "The name of vnet1 VM"
  type        = string
  default     = "matti-vnet1-vm"
}

variable "vnet2_vm" {
  description = "The name of vnet2 VM"
  type        = string
  default     = "matti-vnet2-vm"
}

variable "vm_size" {
  description = "The default VM size for West US2"
  type        = string
  default     = "Standard_B2ats_v2"
}