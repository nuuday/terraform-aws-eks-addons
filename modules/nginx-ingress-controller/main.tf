resource "helm_release" "nginx_ingress" {
  count = var.enable == true ? 1 : 0

  name       = "nginx-ingress-internal"
  chart      = "nginx-ingress"
  version    = var.chart_version
  repository = "https://kubernetes-charts.storage.googleapis.com"
  namespace  = var.namespace
  create_namespace = true
  wait      = "true"

  set {
    name  = "controller.service.type"
    value = "NodePort"
  }

  set {
    name  = "controller.service.nodePorts.http"
    value = var.ingress_controller_http
  }

  set {
    name  = "controller.service.nodePorts.https"
    value = var.ingress_controller_https
  }

  # Preserve the source IP for incoming requests
  # https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typenodeport
  set {
    name  = "controller.service.externalTrafficPolicy"
    value = "Local"
  }

  set {
    name  = "controller.extraArgs.publish-status-address"
    value = var.lb_public_dns
  }

  # Ensure pods are scheduled on Linux nodes only
  set {
    name  = "controller.nodeSelector.kubernetes\\.io/os"
    value = "linux"
  }

  set {
    name  = "defaultBackend.nodeSelector.kubernetes\\.io/os"
    value = "linux"
  }
}

