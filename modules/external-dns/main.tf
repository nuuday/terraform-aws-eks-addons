
locals {
  chart_name    = "external-dns"
  chart_version = var.chart_version
  release_name  = "external-dns"
  namespace     = var.namespace
  repository    = "https://charts.bitnami.com/bitnami"
  values = {
    provider = "aws"
    aws = {
      zoneType = var.zone_type
    }
  }
}


resource "helm_release" "external_dns" {
  count            = var.enable ? 1 : 0
  name             = local.release_name
  chart            = local.chart_name
  version          = local.chart_version
  repository       = local.repository
  namespace        = local.namespace
  create_namespace = true

  wait   = true
  values = [yamlencode(local.values)]

}
