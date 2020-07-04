locals {
  chart_name    = "nginx-ingress"
  chart_version = var.chart_version
  release_name  = "nginx-ingress"
  namespace     = var.namespace
  repository    = "https://kubernetes-charts.storage.googleapis.com"

  values = {
    controller = {
      service = {
        type = "NodePort"

        # Preserve the source IP for incoming requests
        # https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typenodeport
        externalTrafficPolicy = "Local"
        nodePorts             = var.controller_service_node_ports
      }
      extraArgs = {
        "publish-status-address" = var.loadbalancer_fqdn
      }
      nodeSelector = {
        "kubernetes.io/os" = "linux"
      }
    }
    defaultBackend = {
      nodeSelector = {
        "kubernetes.io/os" = "linux"
      }
    }
  }
}

resource "helm_release" "nginx_ingress" {
  count            = var.enable ? 1 : 0
  name             = local.release_name
  chart            = local.chart_name
  version          = local.chart_version
  repository       = local.repository
  namespace        = local.namespace
  create_namespace = true
  wait             = true
}
