resource "kubernetes_deployment_v1" "redis-deployment" {

  depends_on = [
    kubernetes_namespace_v1.namespace,
    kubernetes_persistent_volume_claim_v1.redis-pvc,
  ]

  metadata {
    name      = "redis"
    labels    = local.redis_deployment_labels
    namespace = var.namespace
  }

  spec {

    replicas = 1

    selector {
      match_labels = local.redis_pod_labels
    }

    template {
      metadata {
        name   = "redis"
        labels = local.redis_pod_labels
      }

      spec {

        volume {
          name = "redis-volume"
          persistent_volume_claim {
            claim_name = "redis"
          }
        }

        container {
          image = "redis"
          name  = "redis"
          volume_mount {
            name = "redis-volume"
            mount_path = "/data"
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment_v1" "app-deployment" {

  depends_on = [
    kubernetes_namespace_v1.namespace,
    kubernetes_config_map_v1.app-config,
  ]

  metadata {
    name      = "app"
    labels    = local.app_deployment_labels
    namespace = var.namespace
  }

  spec {
    replicas = var.app_replicas

    selector {
      match_labels = local.app_pod_labels
    }

    template {
      metadata {
        name   = "app"
        labels = local.app_pod_labels
      }

      spec {

        volume {
          name = "index-html"
          config_map {
            name = "app-config"
          }
        }

        container {
          image = "nginx"
          name  = "nginx"

          port {
            container_port = 80
          }

          volume_mount {
            name       = "index-html"
            mount_path = "/usr/share/nginx/html/index.html"
            sub_path   = "index.html"
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment_v1" "app-sample-deployment" {

  depends_on = [
    kubernetes_namespace_v1.namespace
  ]

  metadata {
    name      = "app-sample"
    labels    = local.app_sample_deployment_labels
    namespace = var.namespace
  }

  spec {
    selector {
      match_labels = local.app_sample_pod_labels
    }

    template {
      metadata {
        name   = "app-sample"
        labels = local.app_sample_pod_labels
      }

      spec {

        container {
          image = "nginx"
          name  = "nginx"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}
