resource "kubernetes_namespace" "this" {
  count = var.create_namespace == true ? 1 : 0

  metadata {
    name = var.namespace

    annotations = {
      managedby = "terraform"
    }
  }
}

locals {
  chart_name    = "port-tester"
  chart_version = var.chart_version
  release_name  = "port-tester"
  repository    = "https://harbor.aws.c.dk/chartrepo/shared-platforms"
  create_namespace = true

  values = {
    namespace = var.namespace
    name = "port-tester"
  }
}

resource "helm_release" "port-tester" {
  count      = var.enable ? 1 : 0
  name       = local.release_name
  chart      = local.chart_name
  version    = local.chart_version
  repository = local.repository
  namespace  = var.namespace
  values     = [yamlencode(local.values)]

  depends_on = [
    kubernetes_namespace.this,
  ]
}