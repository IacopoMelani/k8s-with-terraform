resource "kubernetes_ingress_v1" "ingress" {

  depends_on = [
    kubernetes_namespace_v1.namespace,
    kubernetes_service_v1.app-service,
    kubernetes_service_v1.app-sample-service,
  ]

  metadata {
    name      = "app-ingress"
    namespace = var.namespace
    labels = {
      "name" = "app-ingress"
      "kind" = "ingress"
    }
    annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target" = "/"
      "nginx.ingress.kubernetes.io/ssl-redirect" : "false"
    }
  }

  spec {
    rule {
      host = "${var.domain}.minikube.local"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = local.app_service_name
              port {
                number = 8080
              }
            }
          }
        }

        path {
          path      = "/sample"
          path_type = "Prefix"
          backend {
            service {
              name = local.app_sample_service_name
              port {
                number = 8080
              }
            }
          }
        }
      }
    }
  }
}
