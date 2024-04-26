locals {
  custom_tags = {
    Owner         = var.owner
    f5xc-tenant   = var.f5xc_tenant
    f5xc-template = "f5xc_azure_cloud_ce_single_node_multi_nic_existing_vpc_and_subnet_nat_gw_no_eip"
  }
}

resource "azurerm_resource_group" "f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet" {
  name     = format("%s-%s-%s", var.project_prefix, "azure-ce-exists-rg", var.project_suffix)
  location = var.azurerm_region
  provider = azurerm.default
}

resource "azurerm_virtual_network" "f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet" {
  name                = format("%s-%s-%s", var.project_prefix, "azure-ce-exists-vnet", var.project_suffix)
  provider            = azurerm.default
  location            = var.azurerm_region
  address_space       = ["172.16.0.0/21"]
  resource_group_name = azurerm_resource_group.f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet.name
}

resource "azurerm_subnet" "slo" {
  name                 = "node0-subnet-slo"
  provider             = azurerm.default
  address_prefixes     = ["172.16.0.0/24"]
  resource_group_name  = azurerm_resource_group.f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet.name
  virtual_network_name = azurerm_virtual_network.f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet.name
}

resource "azurerm_subnet" "sli" {
  name                 = "node0-subnet-sli"
  provider             = azurerm.default
  address_prefixes     = ["172.16.1.0/24"]
  resource_group_name  = azurerm_resource_group.f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet.name
  virtual_network_name = azurerm_virtual_network.f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet.name
}

module "f5xc_azure_cloud_ce_single_node_multi_nic_existing_vpc_and_subnet_nat_gw_no_eip" {
  depends_on = [
    azurerm_resource_group.f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet,
    azurerm_virtual_network.f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet, azurerm_subnet.slo, azurerm_subnet.sli
  ]
  source            = "../../modules/f5xc/ce/azure"
  owner_tag         = var.owner
  is_sensitive      = false
  has_public_ip     = false
  status_check_type = "cert"
  f5xc_tenant       = var.f5xc_tenant
  f5xc_api_url      = var.f5xc_api_url
  f5xc_namespace    = var.f5xc_namespace
  f5xc_cluster_labels = {}
  f5xc_azure_az_nodes = {
    node0 = {
      az                       = var.azurerm_az_node0
      existing_subnet_name_slo = azurerm_subnet.slo.name
      existing_subnet_name_sli = azurerm_subnet.sli.name
    }
  }
  f5xc_token_name                         = format("%s-%s-%s", var.project_prefix, var.f5xc_cluster_name, var.project_suffix)
  f5xc_cluster_name                       = format("%s-%s-%s", var.project_prefix, var.f5xc_cluster_name, var.project_suffix)
  f5xc_api_p12_file                       = var.f5xc_api_p12_file
  f5xc_ce_gateway_type                    = var.f5xc_ce_gateway_type
  f5xc_is_private_cloud_ce                = true
  f5xc_api_p12_cert_password              = var.f5xc_api_p12_cert_password
  azurerm_region                          = var.azurerm_region
  azurerm_client_id                       = var.azure_client_id
  azurerm_tenant_id                       = var.azure_tenant_id
  azurerm_client_secret                   = var.azure_client_secret
  azurerm_subscription_id                 = var.azure_subscription_id
  azurerm_existing_vnet_name              = azurerm_virtual_network.f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet.name
  azurerm_marketplace_version             = "0.9.2"
  azure_security_group_rules_slo          = []
  azurerm_instance_admin_username         = var.azurerm_instance_admin_username
  azurerm_existing_resource_group_name    = azurerm_resource_group.f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet.name
  azurerm_disable_password_authentication = var.azurerm_disable_password_authentication
  ssh_public_key                          = file(var.ssh_public_key_file)
  providers = {
    azurerm  = azurerm.default
    volterra = volterra.default
  }
}

output "f5xc_azure_cloud_ce_single_node_multi_nic_existing_vpc_and_subnet_nat_gw_no_eip" {
  value = module.f5xc_azure_cloud_ce_single_node_multi_nic_existing_vpc_and_subnet_nat_gw_no_eip
}