locals {
  chart_name    = "cilium"
  chart_version = var.chart_version
  release_name  = "cilium"
  namespace     = var.namespace
  repository    = "https://helm.cilium.io"
  cluster_name  = var.cluster_name
}


resource "helm_release" "cilium" {
  name             = local.release_name
  chart            = local.chart_name
  version          = local.chart_version
  repository       = local.repository
  namespace        = local.namespace
  create_namespace = true

  wait   = true
  values = [file("${path.module}/files/helm/cilium.yaml")]

  set {
    name  = "global.cluster.id"
    value = var.cilium_cluster_id
    type  = "string"
  }

  set {
    name  = "global.cluster.name"
    value = local.cluster_name
    type  = "string"
  }
}
