## Provision AKS Kubernetes Cluster for Learning Purposes

This repo contains terraform templates for creating an Azure Kubernetes Cluster (AKS) for learning purposes. 

Recent requirements/configuration for the AKS cluster:
* Use Calico CNI
* Use Managed Identity
* Two node pools (a System and a User Node Pool) - both of which exist on an Internal Network using the Calico Networking Policy.

In addition to the IaC terraform templates the repo holds the deployment manifest files for different examples/experiments under the `examples` folder.