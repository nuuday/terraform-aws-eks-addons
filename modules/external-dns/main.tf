locals {
  chart_name    = "external-dns"
  chart_version = var.chart_version
  release_name  = "external-dns"
  namespace     = var.namespace
  repository    = "https://charts.bitnami.com/bitnami"
  provider_url  = replace(var.oidc_provider_issuer_url, "https://", "")

  route53_zone_ids = length(var.route53_zones) > 0 ? data.aws_route53_zone.cert_manager.*.id : var.route53_zone_ids

  values = {
    provider = "aws"
    aws = {
      zoneType = var.zone_type
      region   = data.aws_region.external_dns.name

      preferCNAME = var.prefer_cname
    }

    # Optionally prefer CNAME records over ALIAS and A records.
    # When creating CNAMEs, External DNS will have to prefix
    # the TXT records used for registry.
    # Can't have TXT records and CNAME records with the same name.
    txtPrefix = var.prefer_cname ? "prefix" : ""

    zoneIdFilters = local.route53_zone_ids
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

data "aws_route53_zone" "cert_manager" {
  count = length(var.route53_zones)
  name  = var.route53_zones[count.index]
}

resource "random_id" "external_dns" {
  keepers = {
    provider_url = local.provider_url
  }
  byte_length = 16
}

module "iam" {
  # source = "github.com/terraform-aws-modules/terraform-aws-iam//modules/iam-assumable-role-with-oidc?ref=v2.14.0"
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "3.6.0"

  create_role                   = var.enable
  role_name                     = "${local.release_name}-irsa-${random_id.external_dns.hex}"
  provider_url                  = local.provider_url
  oidc_fully_qualified_subjects = ["system:serviceaccount:${local.namespace}:external-dns"]
  tags                          = var.tags
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
      for id in local.route53_zone_ids :
      "arn:aws:route53:::hostedzone/${id}"
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
  count  = var.enable && length(local.route53_zone_ids) > 0 ? 1 : 0
  name   = "cert-manager-${random_id.external_dns.hex}"
  role   = module.iam.this_iam_role_name
  policy = data.aws_iam_policy_document.cert_manager.json
}

resource "helm_release" "external_dns" {
  count      = var.enable ? 1 : 0
  name       = local.release_name
  chart      = local.chart_name
  version    = local.chart_version
  repository = local.repository
  namespace  = local.namespace

  wait   = var.wait
  values = [yamlencode(local.values)]
}

resource "kubernetes_namespace" "this" {
  count = var.create_namespace == true ? 1 : 0

  metadata {
    name = var.namespace

    annotations = {
      managedby = "terraform"
    }
  }
}
