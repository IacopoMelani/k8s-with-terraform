module "mario_rossi" {

  source = "./template"

  providers = {
    kubernetes = kubernetes.minikube
  }

  app_replicas = 1
  app_name     = "Mario Rossi"
  namespace    = "mario-rossi"
  domain       = "mrossi"

  nfs_server = var.nfs_server_1
}

module "marco_verdi" {

  source = "./template"

  providers = {
    kubernetes = kubernetes.minikube
  }

  app_replicas = 1
  app_name     = "Marco Verdi"
  namespace    = "marco-verdi"
  domain       = "mverdi"


  nfs_server = var.nfs_server_1
}

module "sandro_bianchi" {

  source = "./template"

  providers = {
    kubernetes = kubernetes.minikube
  }

  app_replicas = 1
  app_name     = "Sandro Bianchi"
  namespace    = "sandro-bianchi"
  domain       = "sbianchi"

  nfs_server = var.nfs_server_1
}
