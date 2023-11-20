## Provision AKS Kubernetes Cluster for Learning Purposes

This repo contains terraform templates for creating an Azure Kubernetes Cluster (AKS) with the following requirements/configurations:
* CONF-1: Use System Managed Identity
* CONF-2: Use two node pools (`master` and `worker`) - both of which exist on an Internal Network using the Calico Networking Policy.
* CONF-3: Enable Kubernetes RBAC and AKS-managed Azure AD integration
* CONF-4: Enable Azure AD Workload Identity 
* CONF-5: Enable OIDC Issuer (required for the Workload Identity)
* CONF-6: Disable local accounts
* CONF-7: Secure access to the API server using authorized IP ranges
* CONF-8: Managed nginx Ingress with the application routing add-on

In addition to the AKS cluster IaC, the repo holds the deployment manifest files for different examples/experiments under the `manifests` folder. Also, these examples will continuously be converted into terraform templates.