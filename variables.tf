variable "prefix" {
  description = "A prefix used for all resources in the templates"
  default     = "akscalico"
}

variable "rg_name" {
  description = "Name of the Azure Ressource Group"
  type        = string
  default     = "learning-aks"
}

variable "location" {
  description = "Location of the Azure Ressource Group"
  type        = string
  default     = "North Europe"
}

variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default = {
    environment  = "dev"
  }
}

variable "master_vm_size" {
  description = "The VM size (SKU) for the master node."
  type        = string
  default     = "Standard_B2ms"
}

variable "worker_vm_size" {
  description = "The VM size (SKU) for the worker node."
  type        = string
  default     = "Standard_B2ms"
}

variable "k8s_version" {
  description = "The Kubernetes version specified for the cluster."
  type        = string
  default     = "1.25"
}

variable "admin_groups" {
  description = "A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster."
  type        = list(string)
  default     = []
}

variable "authorized_ips" {
  description = "A list of IP ranges (CIDR) that are authorized to access the Cluster."
  type        = list(string)
  default     = []
}