output "id" {
  value = azurerm_kubernetes_cluster.aks1.id
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks1.kube_config_raw
  sensitive = true
}