resource "helm_release" "this" {
  count      = var.enable ? 1 : 0
  name       = "aws-efs-csi-driver"
  chart      = "aws-efs-csi-driver"
  version    = var.chart_version
  repository = "https://kubernetes-sigs.github.io/aws-efs-csi-driver/"
  wait       = true
}
