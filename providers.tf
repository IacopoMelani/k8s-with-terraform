terraform {
  backend "local" {
    path = "./state/terraform.tfstate"
  }
}

provider "kubernetes" {
  alias          = "minikube"
  config_path    = "~/.kube/config"
  config_context = "minikube"
}
