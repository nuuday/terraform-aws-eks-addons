data "aws_region" "current" {}

data "aws_eks_cluster" "this" {
  count = var.enable ? 1 : 0
  name = var.cluster_name
}

locals {
  chart_name      = "cluster-autoscaler"
  chart_version   = var.chart_version
  release_name    = "aws-cluster-autoscaler"
  namespace       = var.namespace
  repository      = "https://kubernetes-charts.storage.googleapis.com"
  service_account = "aws-cluster-autoscaler"
  provider_url    = replace(var.oidc_provider_issuer_url, "https://", "")

  # Use supplied tags if provided, otherwise use defaults.
  asg_tags = length(var.asg_tags) > 0 ? var.tags : {
    "k8s.io/cluster-autoscaler/${data.aws_eks_cluster.this[0].name}" = "owned"
    "k8s.io/cluster-autoscaler/enabled"             = "true"
  }
}

module "iam" {
  source = "github.com/terraform-aws-modules/terraform-aws-iam//modules/iam-assumable-role-with-oidc?ref=v2.10.0"

  create_role                   = var.enable
  role_name                     = "${data.aws_eks_cluster.this[0].name}-cluster-autoscaler-irsa"
  provider_url                  = local.provider_url
  oidc_fully_qualified_subjects = ["system:serviceaccount:${local.namespace}:${local.service_account}"]

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

resource "helm_release" "cluster_autoscaler" {
  count = var.enable ? 1 : 0

  name             = local.release_name
  chart            = local.chart_name
  version          = local.chart_version
  repository       = local.repository
  namespace        = local.namespace
  create_namespace = true

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
    name  = "rbac.serviceAccount.name"
    value = local.service_account
  }

  set {
    name  = "rbac.serviceAccountAnnotations.eks\\.amazonaws\\.com/role-arn"
    value = module.iam.this_iam_role_arn
    type  = "string"
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = data.aws_eks_cluster.this[0].name
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
