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

variable "vnet_peering1" {
  description = "The name of the first network peering."
  type        = string
  default     = "peer1to2"
}

variable "vnet_peering2" {
  description = "The name of the second network peering."
  type        = string
  default     = "peer2to1"
}

variable "vnet1_address_space" {
  description = "The address space of the first virtual network."
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "vnet2_address_space" {
  description = "The address space of the second virtual network."
  type        = list(string)
  default     = ["10.0.2.0/24"]
}