variable "project_prefix" {
  type        = string
  description = "prefix string put in front of string"
}

variable "project_suffix" {
  type        = string
  description = "prefix string put at the end of string"
}

variable "owner" {
  description = "Azure tag owner email address"
  type        = string
}

variable "ssh_public_key_file" {
  description = "path to ssh public key file"
  type        = string
}

variable "azurerm_instance_admin_username" {
  type        = string
  description = "Azure VM instance username"
  default     = "operator"
}

variable "azurerm_disable_password_authentication" {
  type        = bool
  description = "Azure VM disable user password authentication"
  default     = true
}

variable "azurerm_existing_subnet_name_node0_slo" {
  description = "existing azure subnet for node0 slo"
  type        = string
}

variable "azurerm_existing_subnet_name_node1_slo" {
  description = "existing azure subnet for node1 slo"
  type        = string
}

variable "azurerm_existing_subnet_name_node2_slo" {
  description = "existing azure subnet for node2 slo"
  type        = string
}

variable "azurerm_region" {
  type = string
}

variable "azurerm_existing_vnet_name" {
  description = "Azure existing vnet name"
  type        = string
}

variable "azurerm_existing_resource_group_name" {
  description = "Azure existing resource group name"
  type        = string
}

variable "f5xc_api_p12_file" {
  description = "F5 XC API certificate file"
  type        = string
}

variable "f5xc_api_p12_cert_password" {
  description = "F5 XC API certificate file password"
  type        = string
  default     = ""
}

variable "f5xc_api_url" {
  description = "F5 XC API URL"
  type        = string
}

variable "f5xc_api_token" {
  description = "F5 XC API token"
  type        = string
  default     = ""
}

variable "f5xc_tenant" {
  description = "F5 XC Tenant name"
  type        = string
}

variable "f5xc_namespace" {
  description = "F5 XC namespace name"
  type        = string
  default     = "system"
}

variable "f5xc_cluster_name" {
  description = "F5 XC CE cluster name"
  type        = string
}

variable "f5xc_ce_gateway_type" {
  description = "F5 XC CE gateway type to set single NIC or multi NIC"
  type        = string
  default     = "ingress_gateway"
}

variable "f5xc_cluster_latitude" {
  description = "F5 XC CE geo latitude"
  type        = number
  default     = -73.935242
}

variable "f5xc_cluster_longitude" {
  description = "F5 XC CE geo longitude"
  type        = number
  default     = 40.730610
}

variable "f5xc_azure_az_node0" {
  type = string
}

variable "f5xc_azure_az_node1" {
  type = string
}

variable "f5xc_azure_az_node2" {
  type = string
}

variable "azure_client_id" {
  type    = string
  default = ""
}

variable "azure_client_secret" {
  type    = string
  default = ""
}

variable "azure_tenant_id" {
  type    = string
  default = ""
}

variable "azure_subscription_id" {
  type    = string
  default = ""
}