resource "kubernetes_persistent_volume_claim_v1" "hello-logs-pvc" {
  metadata {
    name      = "hello-logs"
    namespace = var.namespace
    labels = local.hello_logs_pvc_labels
    annotations = {
      "nfs.io/storage-path" = "logs"
    }
  }

  spec {
    storage_class_name = var.nfs_client
    access_modes       = ["ReadWriteMany"]
    resources {
      requests = {
        "storage" = "200Mi"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim_v1" "redis-pvc" {
  metadata {
    name      = "redis"
    namespace = var.namespace
    labels    = local.redis_pvc_labels
    annotations = {
      "nfs.io/storage-path" = "redis"
    }
  }

  spec {
    storage_class_name = var.nfs_client
    access_modes       = ["ReadWriteOnce"]
    resources {
      requests = {
        "storage" = "50Mi"
      }
    }
  }
}
