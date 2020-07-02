

# Add Kubernetes Stable Helm charts repo
# https://github.com/helm/charts/tree/master/stable/nginx-ingress

resource "null_resource" "update_helm_repo" {
  provisioner "local-exec" {
    command = "helm repo update"
  }
}


resource "helm_release" "nginx_ingress" {
  count = var.enable == true ? 1 : 0

  name    = "nginx-ingress-internal"
  chart   = "nginx-ingress"
  version = var.nginx_ingress_chart_version

  repository       = "https://kubernetes-charts.storage.googleapis.com"
  namespace        = var.kubernetes_namespace
  create_namespace = true
  wait             = true

  set {
    name  = "controller.service.type"
    value = "NodePort"
  }

  set {
    name  = "controller.service.nodePorts.http"
    value = var.controller_service_nodeports_http
  }

  set {
    name  = "controller.service.nodePorts.https"
    value = var.controller_service_nodeports_https
  }

  # Preserve the source IP for incoming requests
  # https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typenodeport
  set {
    name  = "controller.service.externalTrafficPolicy"
    value = "Local"
  }

  set {
    name  = "controller.extraArgs.publish-status-address"
    value = var.lb_fqdn
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

  depends_on = [
    null_resource.update_helm_repo
  ]

}
