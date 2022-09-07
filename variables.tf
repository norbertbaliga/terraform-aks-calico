variable "prefix" {
  description = "A prefix used for all resources in the templates"
  default     = "akscalico"
}

variable "location" {
  description = "The Azure Region in which all resources should be provisioned"
  default     = "North Europe"
}