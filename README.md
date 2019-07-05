# Azure Kubernetes Service (AKS) Terraform Module

This modules allows to deploy an Azure Kubernetes Service cluster into an existing subnet.
It is part of the reference archicture for Terraform on Azure. More details can be found on the [main repository](https://github.com/jcorioland/terraform-azure-reference). 

## Usage

```hcl
module "tf-ref-aks-module" {
  source                           = "../../"
  environment                      = "Development"
  location                         = "westeurope"
  kubernetes_version               = "1.13.5"
  ssh_public_key                   = "$file('~/.ssh/id_rsa.pub')"
  service_principal_client_id      = "CLIENT_ID"
  service_principal_client_secret  = "CLIENT_SECRET"
}
```

## Scenarios

It is part of the reference architecture for Terraform on Azure. More details can be found on the [main repository](https://github.com/jcorioland/terraform-azure-reference). 

## Examples

You can find an example of usage [here](examples/).

## Inputs

```hcl
variable "environment" {
  description = "Name of the environment"
}

variable "location" {
  description = "Azure location to use"
}

variable "kubernetes_version" {
  description = "Kubernetes version to use"
}

variable "ssh_public_key" {
  description = "The SSH public key for AKS"
}

variable "service_principal_client_id" {
  description = "The client id of the service principal to be used by AKS"
}

variable "service_principal_client_secret" {
  description = "The client secret of the service principal to be used by AKS"
}
```

## Outputs

```hcl
output "resource_group_name" {
  value = "${data.azurerm_resource_group.rg.name}"
}

output "aks_client_key" {
  value = "${azurerm_kubernetes_cluster.aks.kube_config.0.client_key}"
}

output "aks_client_certificate" {
  value = "${azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate}"
}

output "aks_cluster_ca_certificate" {
  value = "${azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate}"
}

output "aks_cluster_username" {
  value = "${azurerm_kubernetes_cluster.aks.kube_config.0.username}"
}

output "aks_cluster_password" {
  value = "${azurerm_kubernetes_cluster.aks.kube_config.0.password}"
}

output "aks_kube_config" {
  value = "${azurerm_kubernetes_cluster.aks.kube_config_raw}"
}

output "aks_host" {
  value = "${azurerm_kubernetes_cluster.aks.kube_config.0.host}"
}
```

## Run tests

```bash
dep ensure
export TF_VAR_service_principal_client_id="<CLIENT_ID>"
export TF_VAR_service_principal_client_secret="<CLIENT_SECRET>"
go test -v ./test/ -timeout 20m
```