terraform {
  backend "local" {
    path = "./.state/terraform.tfstate"
  }

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.8.0"
    }
  }
}

provider "kubernetes" {
  alias          = "minikube"
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

provider "helm" {
  repository_config_path = "${path.module}/.helm/repositories.yaml"
  repository_cache       = "${path.module}/.helm"
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "minikube"
  }
}
