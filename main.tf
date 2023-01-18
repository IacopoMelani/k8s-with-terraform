
module "mario_rossi" {

  source = "./template"

  providers = {
    kubernetes = kubernetes.minikube
  }

  app_name  = "Mario Rossi"
  namespace = "mario-rossi"
  domain    = "mrossi"
}

module "marco_verdi" {

  source = "./template"

  providers = {
    kubernetes = kubernetes.minikube
  }

  app_name  = "Marco Verdi"
  namespace = "marco-verdi"
  domain    = "mverdi"
}

module "sandro_bianchi" {

  source = "./template"

  providers = {
    kubernetes = kubernetes.minikube
  }

  app_name  = "Sandro Bianchi"
  namespace = "sandro-bianchi"
  domain    = "sbianchi"
}
