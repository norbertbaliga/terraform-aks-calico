# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  cloud {
    organization = "norbertbaliga-goto"
    workspaces {
      name = "tf-aks-calico"
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.49.0"
    }
  }

  required_version = ">= 1.4"
}