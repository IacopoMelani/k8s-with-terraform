resource "kubernetes_job_v1" "init-pv" {

  metadata {
    name      = "init-pv"
    namespace = var.namespace
    labels = {
      "name" = "init-pv"
      "kind" = "job"
    }
  }

  spec {

    template {

      metadata {
        name = "init-pv"
        labels = {
          "name" = "init-pv"
          "kind" = "pod"
        }
      }

      spec {

        volume {
          name = "init-pv"
          nfs {
            server = var.nfs_server
            path   = "/"
          }
        }
        container {
          name              = "hello"
          image             = "busybox:1.28"
          image_pull_policy = "IfNotPresent"
          command           = ["/bin/sh", "-c"]
          args              = ["mkdir -p /app/${var.namespace}"]
          volume_mount {
            name       = "init-pv"
            mount_path = "/app"
          }
        }
      }
    }
  }
}

resource "kubernetes_persistent_volume_v1" "pv" {

  depends_on = [
    kubernetes_job_v1.init-pv,
  ]

  metadata {
    name = var.namespace
    labels = {
      "name" = var.namespace
      "kind" = "pv"
    }
  }

  spec {
    capacity = {
      "storage" = "1Gi"
    }
    access_modes = ["ReadWriteMany"]
    persistent_volume_source {
      nfs {
        server = var.nfs_server
        path   = "/${var.namespace}"
      }
    }
    claim_ref {
      name      = var.namespace
      namespace = var.namespace
    }
  }
}


resource "kubernetes_persistent_volume_claim_v1" "pvc" {

  depends_on = [
    kubernetes_persistent_volume_v1.pv,
  ]

  metadata {
    name      = var.namespace
    namespace = var.namespace
    labels = {
      "name" = var.namespace
      "kind" = "pvc"
    }
  }

  spec {
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        "storage" = "1Gi"
      }
    }
  }
}
