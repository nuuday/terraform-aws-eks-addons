data "aws_region" "current" {}

locals {
  # Use supplied tags if provided, otherwise use defaults.
  asg_tags = length(var.asg_tags) > 0 ? var.tags : {
    "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned"
    "k8s.io/cluster-autoscaler/enabled"             = "true"
  }
}

module "iam" {
  source = "github.com/terraform-aws-modules/terraform-aws-iam//modules/iam-assumable-role-with-oidc?ref=v2.10.0"

  create_role                   = var.enable
  role_name                     = "${var.cluster_name}-cluster-autoscaler-irsa"
  provider_url                  = var.oidc_provider_issuer
  oidc_fully_qualified_subjects = ["system:serviceaccount:${kubernetes_namespace.cluster_autoscaler.0.metadata.0.name}:aws-cluster-autoscaler"]

  tags = var.tags
}

data "aws_iam_policy_document" "cluster_autoscaler" {
  statement {
    sid = "Read"

    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeTags",
      "ec2:DescribeLaunchTemplateVersions",
    ]

    resources = ["*"]
  }

  statement {
    sid = "Write"

    actions = [
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup",
      "autoscaling:UpdateAutoScalingGroup",
    ]

    resources = ["*"]

    dynamic "condition" {
      for_each = local.asg_tags
      iterator = tag

      content {
        test     = "StringEqualsIgnoreCase"
        variable = "autoscaling:ResourceTag/${tag.key}"
        values   = [tag.value]
      }
    }
  }
}

resource "aws_iam_role_policy" "cluster_autoscaler" {
  count = var.enable ? 1 : 0

  name = "ClusterAutoscaler"
  role = module.iam.this_iam_role_name

  policy = data.aws_iam_policy_document.cluster_autoscaler.json
}

resource "kubernetes_namespace" "cluster_autoscaler" {
  count = var.enable ? 1 : 0

  metadata {
    name = "cluster-autoscaler"
  }
}

resource "helm_release" "cluster_autoscaler" {
  count = var.enable ? 1 : 0

  name       = "aws-cluster-autoscaler"
  chart      = "cluster-autoscaler"
  version    = var.chart_version
  repository = "https://kubernetes-charts.storage.googleapis.com"
  namespace  = kubernetes_namespace.cluster_autoscaler.0.metadata.0.name

  set {
    name  = "cloudProvider"
    value = "aws"
  }

  set {
    name  = "awsRegion"
    value = data.aws_region.current.name
  }

  set {
    name  = "rbac.create"
    value = true
  }

  set {
    name  = "rbac.serviceAccount.create"
    value = true
  }

  set {
    name  = "rbac.serviceAccountAnnotations.eks\\.amazonaws\\.com/role-arn"
    value = module.iam.this_iam_role_arn
    type  = "string"
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = var.cluster_name
  }

  set {
    name  = "autoDiscovery.enabled"
    value = true
  }

  set {
    name  = "nodeSelector.kubernetes\\.io/os"
    value = "linux"
    type  = "string"
  }
}
