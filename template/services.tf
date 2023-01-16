resource "kubernetes_service_v1" "redis-service" {

  depends_on = [
    kubernetes_namespace_v1.namespace,
  ]

  metadata {
    name      = "redis"
    labels    = local.redis_service_labels
    namespace = var.namespace
  }

  spec {
    type = "ClusterIP"
    port {
      port        = 6379
      target_port = 6379
    }
    selector = local.redis_pod_labels
  }
}

resource "kubernetes_service_v1" "app-service" {

  depends_on = [
    kubernetes_namespace_v1.namespace,
  ]

  metadata {
    name      = "app"
    labels    = local.app_service_labels
    namespace = var.namespace
  }

  spec {
    type = "ClusterIP"
    port {
      port        = 8080
      target_port = 80
    }
    selector = local.app_pod_labels
  }
}

resource "kubernetes_service_v1" "app-sample-service" {

  depends_on = [
    kubernetes_namespace_v1.namespace,
  ]

  metadata {
    name      = "app-sample"
    labels    = local.app_sample_service_labels
    namespace = var.namespace
  }

  spec {
    type = "ClusterIP"
    port {
      port        = 8080
      target_port = 80
    }
    selector = local.app_sample_pod_labels
  }
}
