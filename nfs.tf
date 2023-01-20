
resource "helm_release" "nfs-provisioner-1" {
  name       = "nfs-provisioner-1"
  repository = "https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/"
  chart      = "nfs-subdir-external-provisioner"

  set {
    name  = "nfs.server"
    value = var.nfs_server_1
  }

  set {
    name  = "nfs.path"
    value = "/apps"
  }

  set {
    name  = "storageClass.name"
    value = "nfs-client-1"
  }

  set {
    name  = "storageClass.provisionerName"
    value = "k8s-sigs.io/nfs-provisioner-1"
  }

  set {
    name  = "storageClass.pathPattern"
    value = "$${.PVC.namespace}/$${.PVC.annotations.nfs.io/storage-path}"
  }
}
