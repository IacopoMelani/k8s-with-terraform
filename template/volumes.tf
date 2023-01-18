
resource "kubernetes_persistent_volume_claim_v1" "hello-logs-pvc" {
  metadata {
    name      = "hello-logs"
    namespace = var.namespace
    labels = {
      "name" = "hello-logs"
      "kind" = "pvc"
    }
    annotations = {
      "nfs.io/storage-path" = "logs"
    }
  }

  spec {
    storage_class_name = "nfs-client-1"
    access_modes       = ["ReadWriteMany"]
    resources {
      requests = {
        "storage" = "200Mi"
      }
    }
  }
}
