locals {
  release_name = "aws-node-termination-handler"
  chart_name   = "aws-node-termination-handler"
  namespace    = var.namespace
  repository   = "https://aws.github.io/eks-charts"
}


resource "helm_release" "node_termination_handler" {
  count            = var.enable ? 1 : 0
  name             = local.release_name
  chart            = local.chart_name
  version          = var.chart_version
  repository       = local.repository
  namespace        = local.namespace
  create_namespace = true
  wait             = true

  # Ensure the pods only run on Linux nodes,
  # in case we have Windows nodes in our cluster too.
  set {
    name  = "nodeSelector.kubernetes\\.io/os"
    value = "linux"
    type  = "string"
  }
}