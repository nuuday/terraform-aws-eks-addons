resource "kubernetes_namespace" "this" {
  count = var.create_namespace ? 1 : 0

  metadata {
    name = var.namespace
  }
}

resource "helm_release" "calico" {
  count = var.enable ? 1 : 0

  name       = "aws-calico"
  chart      = "aws-calico"
  version    = var.chart_version
  repository = "https://aws.github.io/eks-charts"
  namespace  = var.namespace
  wait       = true

  depends_on = [kubernetes_namespace.this]
}
