resource "kubernetes_namespace" "this" {
  count = var.create_namespace ? 1 : 0

  metadata {
    name = var.namespace
  }
}

resource "null_resource" "apply_crds" {
  count = var.enable ? 1 : 0

  provisioner "local-exec" {
    command = <<EOF
cat <<MOF | kubectl \
  --insecure-skip-tls-verify \
  --token ${var.kubectl_token} \
  --server ${var.kubectl_server} \
    apply -k "./crds"
MOF
EOF
  }
}

resource "helm_release" "calico" {
  count      = var.enable ? 1 : 0
  name       = "aws-calico"
  chart      = "aws-calico"
  version    = var.chart_version
  repository = "https://aws.github.io/eks-charts"
  namespace  = var.namespace
  wait       = true

  depends_on = [kubernetes_namespace.this]
}
