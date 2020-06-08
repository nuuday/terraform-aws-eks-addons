

data "aws_eks_cluster" "this" {
  name = var.eks_cluster_name
}

data "aws_eks_cluster_auth" "this" {
  name = var.eks_cluster_name
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.this.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.this.token
    load_config_file       = false
  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.this.token
  load_config_file       = false
  version                = "~> 1.9"
}



resource "kubernetes_namespace" "nginx_ingress" {
  count = var.ingress_controller_enable == true ? 1 : 0

  metadata {
    name = var.kubernetes_namespace
  }

}

resource "null_resource" "update_helm_repo" {

  provisioner "local-exec" {
    command = "helm repo update"
  }
}


# Add Kubernetes Stable Helm charts repo
# https://github.com/helm/charts/tree/master/stable/nginx-ingress

data "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}

resource "helm_release" "nginx_ingress" {
  count = var.ingress_controller_enable == true ? 1 : 0

  name    = "nginx-ingress-internal"
  chart   = "nginx-ingress"
  version = var.nginx_ingress_chart_version
  #repository = data.helm_repository.stable.metadata.0.name
  repository = "https://kubernetes-charts.storage.googleapis.com"
  namespace  = kubernetes_namespace.nginx_ingress[0].metadata.0.name
  wait       = "true"

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
    value = var.lb_dns_name
  }

  # Ensure pods are scheduled on Linux nodes only
  set {
    name  = "controller.nodeSelector.kubernetes\\.io/os"
    value = var.defaultBackend_nodeSelector
  }

  set {
    name  = "defaultBackend.nodeSelector.kubernetes\\.io/os"
    value = var.defaultBackend_nodeSelector
  }

  depends_on = [
    kubernetes_namespace.nginx_ingress,
    null_resource.update_helm_repo
  ]
}

