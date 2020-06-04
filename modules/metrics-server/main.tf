locals {
  chart_name   = "metrics-server"
  release_name = "metrics-server"
  namespace    = var.namespace
  repository   = "https://kubernetes-charts.storage.googleapis.com"
}


resource "helm_release" "metrics-server" {
  count            = var.enabled ? 1 : 0
  name             = local.release_name
  chart            = local.chart_name
  version          = var.chart_version
  repository       = local.repository
  namespace        = local.namespace
  wait             = false
  create_namespace = true


  set {
    name  = "nodeSelector.kubernetes\\.io/os"
    value = "linux"
    type  = "string"
  }
}
