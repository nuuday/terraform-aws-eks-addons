
locals {
  chart_name    = "external-dns"
  chart_version = var.chart_version
  release_name  = "external-dns"
  namespace     = var.namespace
  repository    = "https://charts.bitnami.com/bitnami"
  provider_url  = replace(var.oidc_provider_issuer_url, "https://", "")

  values = {
    provider = "aws"
    aws = {
      zoneType = var.zone_type
      region   = data.aws_region.external_dns.name
    }
    domainFilters = var.route53_zones
    nodeSelector = {
      "kubernetes.io/os" = "linux"
    }
    serviceAccount = {
      annotations = {
        "eks.amazonaws.com/role-arn" = module.iam.this_iam_role_arn
      }
    }
    metrics = {
      enabled = true
    }
  }
}

data aws_region "external_dns" {}

resource "random_id" "external_dns" {
  keepers = {
    provider_url = local.provider_url
  }
  byte_length = 16
}

module "iam" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  create_role                   = var.enable
  role_name                     = "${local.release_name}-irsa-${random_id.external_dns.hex}"
  provider_url                  = local.provider_url
  oidc_fully_qualified_subjects = ["system:serviceaccount:${local.namespace}:external-dns"]
  tags                          = var.tags
}

data "aws_route53_zone" "cert_manager" {
  count = length(var.route53_zones)
  name  = var.route53_zones[count.index]
}


data "aws_iam_policy_document" "cert_manager" {
  statement {
    actions = [
      "route53:GetChange"
    ]
    resources = ["arn:aws:route53:::change/*"]
  }
  statement {
    actions = [
      "route53:ChangeResourceRecordSets",
      "route53:ListResourceRecordSets"
    ]
    resources = [
      for zone in data.aws_route53_zone.cert_manager :
      "arn:aws:route53:::hostedzone/${zone.zone_id}"
    ]
  }
  statement {
    actions = [
      "route53:ListHostedZonesByName",
      "route53:ListHostedZones"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "cert_manager" {
  count  = var.enable && length(var.route53_zones) > 0 ? 1 : 0
  name   = "cert-manager-${random_id.external_dns.hex}"
  role   = module.iam.this_iam_role_name
  policy = data.aws_iam_policy_document.cert_manager.json
}



resource "helm_release" "external_dns" {
  count            = var.enable ? 1 : 0
  name             = local.release_name
  chart            = local.chart_name
  version          = local.chart_version
  repository       = local.repository
  namespace        = local.namespace
  create_namespace = true

  wait   = true
  values = [yamlencode(local.values)]

}