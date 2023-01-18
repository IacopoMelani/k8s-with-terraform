
resource "kubernetes_cron_job_v1" "hello" {

  depends_on = [
    kubernetes_namespace_v1.namespace,
    kubernetes_persistent_volume_claim_v1.hello-logs-pvc,
  ]

  metadata {
    name      = "hello"
    namespace = var.namespace
    labels    = local.hello_cronjob_labels
  }

  spec {
    schedule                      = "* * * * *"
    successful_jobs_history_limit = 3
    failed_jobs_history_limit     = 3

    job_template {

      metadata {
        name   = "hello"
        labels = local.hello_job_labels
      }

      spec {

        template {

          metadata {
            name   = "hello"
            labels = local.hello_pod_labels
          }

          spec {

            restart_policy = "OnFailure"
            volume {
              name = "hello-logs-volume"
              persistent_volume_claim {
                claim_name = "hello-logs"
              }
            }
            container {
              name              = "hello"
              image             = "busybox:1.28"
              image_pull_policy = "IfNotPresent"
              command           = ["/bin/sh", "-c"]
              args              = ["date; echo \"[$(date)] Cron Job from ${var.app_name} app\" >> /app/logs/hello.logs"]
              volume_mount {
                name       = "hello-logs-volume"
                mount_path = "/app/logs"
              }
            }
          }
        }
      }
    }
  }
}
