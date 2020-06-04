locals {
  chart_name    = "prometheus"
  chart_version = var.chart_version
  release_name  = "prometheus"
  namespace     = var.namespace
  repository    = "https://kubernetes-charts.storage.googleapis.com"
}

resource "helm_release" "prometheus" {
  name       = local.release_name
  chart      = local.chart_name
  version    = local.chart_version
  repository = local.repository
  namespace  = local.namespace

  wait   = false
  values = [file("${path.module}/files/helm/prometheus.yaml")]


  set {
    name  = "server.retention"
    value = var.retention
    type  = "string"
  }

  set {
    name  = "server.persistentVolume.size"
    value = var.persistence_size
    type  = "string"
  }

  set {
    name  = "server.resources.requests.memory"
    value = var.resources_request_memory
    type  = "string"
  }
  set {
    name  = "server.resources.requests.cpu"
    value = var.resources_request_cpu
    type  = "string"
  }
}
