locals {
  chart_name    = "loki-stack"
  chart_version = var.chart_version
  release_name  = "loki"
  namespace     = var.namespace
  repository    = "https://grafana.github.io/loki/charts"
}

resource "helm_release" "loki" {
  count      = var.enable ? 1 : 0
  name       = local.release_name
  chart      = local.chart_name
  version    = local.chart_version
  repository = local.repository
  namespace  = local.namespace

  wait   = false
  values = [file("${path.module}/files/helm/loki.yaml")]

  set {
    name  = "loki.resources.requests.memory"
    value = var.resources_request_memory
    type  = "string"
  }
  set {
    name  = "loki.resources.requests.cpu"
    value = var.resources_request_cpu
    type  = "string"
  }

  set {
    name  = "loki.persistence.size"
    value = var.persistence_size
    type  = "string"
  }
}
