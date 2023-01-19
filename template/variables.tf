variable "namespace" {}
variable "app_name" {}
variable "domain" {}
variable "app_replicas" {
    default = 1
}
variable "nfs_client" {
  default = "nfs-client-1"
}