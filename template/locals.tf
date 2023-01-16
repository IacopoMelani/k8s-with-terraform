locals {
  # Namespace

  namespace_labels = {
    "name" = var.namespace
    "kind" = "namespace"
  }

  # Redis

  redis_deployment_labels = {
    "name" = "redis"
    "kind" = "deployment"
  }
  redis_pod_labels = {
    "name" = "redis"
    "kind" = "pod"
  }
  redis_service_labels = {
    "name" = "redis"
    "kind" = "service"
  }

  # App 

  app_deployment_labels = {
    "name" = "app"
    "kind" = "deployment"
  }
  app_pod_labels = {
    "name" = "app"
    "kind" = "pod"
  }
  app_service_labels = {
    "name" = local.app_service_name
    "kind" = "service"
  }
  app_service_name = "app"

  # App Sample

  app_sample_deployment_labels = {
    "name" = "app-sample"
    "kind" = "deployment"
  }
  app_sample_pod_labels = {
    "name" = "app-sample"
    "kind" = "pod"
  }
  app_sample_service_labels = {
    "name" = local.app_sample_service_name
    "kind" = "service"
  }
  app_sample_service_name = "app-sample"

  # Hello

  hello_cronjob_labels = {
    "name" = "hello"
    "kind" = "cron-job"
  }
  hello_job_labels = {
    "name" = "hello"
    "kind" = "job"
  }
  hello_pod_labels = {
    "name" = "hello"
    "kind" = "pod"
  }
}
