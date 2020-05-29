data "aws_region" "current" {}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}

provider "kubernetes" {
  version = "~>1.11"

  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}

locals {
  # Use supplied tags if provided, otherwise use defaults.
  asg_tags = length(var.asg_tags) > 0 ? var.tags : {
    "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned"
    "k8s.io/cluster-autoscaler/enabled"             = "true"
  }
}

resource "aws_iam_role" "cluster_autoscaler" {
  count = var.enable ? 1 : 0

  name_prefix = "${var.cluster_name}-autoscaler"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "${var.oidc_provider_arn}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "${var.oidc_provider_issuer}:sub": "system:serviceaccount:${kubernetes_namespace.cluster_autoscaler.0.metadata.0.name}:aws-cluster-autoscaler"
        }
      }
    }
  ]
}
EOF

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
  role = aws_iam_role.cluster_autoscaler.0.id

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
    value = aws_iam_role.cluster_autoscaler.0.arn
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
