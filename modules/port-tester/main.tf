locals {
  chart_name    = "port-tester"
  chart_version = var.chart_version
  release_name  = "port-tester"
  repository    = "https://harbor.aws.c.dk/chartrepo/shared-platforms"
}

resource "helm_release" "port-tester" {
  count      = var.enable ? 1 : 0
  name       = local.release_name
  chart      = local.chart_name
  version    = local.chart_version
  repository = local.repository
}