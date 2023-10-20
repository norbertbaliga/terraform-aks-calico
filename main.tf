provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location

  tags = var.resource_tags
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "${var.prefix}-vnet1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.1.0.0/16"]

  tags = var.resource_tags
}

resource "azurerm_subnet" "internal" {
  name                 = "subnet-int"
  virtual_network_name = azurerm_virtual_network.vnet1.name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = ["10.1.0.0/22"]
}

resource "azurerm_kubernetes_cluster" "aks1" {
  name                = "${var.prefix}-cluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.prefix}-cluster"
  kubernetes_version  = var.k8s_version

# CONF-3: AKS-managed Azure Active Directory integration
  azure_active_directory_role_based_access_control {
    managed                = true
    admin_group_object_ids = var.admin_groups
    azure_rbac_enabled     = true
  }

  default_node_pool {
    name                = "master"
    enable_auto_scaling = false
    node_count          = 1
    vm_size             = var.master_vm_size
    vnet_subnet_id      = azurerm_subnet.internal.id

    tags = var.resource_tags
  }

  network_profile {
    network_plugin    = "azure"     # When network_plugin is set to azure vnet_subnet_id field in the default_node_pool block must be set and pod_cidr must not be set.
    network_policy    = "calico"    # CONF-2
    load_balancer_sku = "standard"
  }

  # Restrict public access to authorized CIDR ranges only
  api_server_access_profile {
    authorized_ip_ranges = var.authorized_ips # CONF-7
  }

  identity {
    type = "SystemAssigned"   # CONF-1
  }

  # Preview feature: https://learn.microsoft.com/en-us/azure/aks/workload-identity-deploy-cluster#register-the-enableworkloadidentitypreview-feature-flag
  oidc_issuer_enabled       = true  # CONF-5
  workload_identity_enabled = true  # CONF-4

  # Disable local accounts
  local_account_disabled    = true  # CONF-6

  tags = var.resource_tags
}

resource "azurerm_kubernetes_cluster_node_pool" "np1" {
  name                  = "worker"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks1.id
  vm_size               = var.worker_vm_size
  enable_auto_scaling   = false
  node_count            = 1
  vnet_subnet_id        = azurerm_subnet.internal.id

  tags = var.resource_tags
}