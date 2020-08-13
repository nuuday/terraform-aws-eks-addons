locals {
  chart_name     = "loki-stack"
  chart_version  = var.chart_version
  release_name   = "loki"
  namespace      = var.namespace
  repository     = "https://grafana.github.io/loki/charts"
  provider_url   = replace(var.oidc_provider_issuer_url, "https://", "")
  bucket_prefix  = "${var.cluster_name}-loki"
  bucket_name    = module.s3_bucket.this_s3_bucket_id
  dynamodb_table = local.bucket_name
  role_name      = local.bucket_name

  loki_values = {
    promtail = {
      resources = {
        requests = {
          cpu    = "50m"
          memory = "128Mi"
        }
      }
    }

    loki = {
      serviceAccount = {
        annotations = {
          "eks.amazonaws.com/role-arn" = module.iam.this_iam_role_arn
        }
      }
      resources = {
        requests = {
          cpu    = "200m"
          memory = "256Mi"
        }
      }
      persistence = {
        enabled = false
      }
      networkPolicy = {
        enabled = true
      }
      config = {
        schema_config = {
          configs : [
            {
              from         = "2020-05-15"
              store        = "aws"
              object_store = "s3"
              schema       = "v11"
              index = {
                prefix = local.dynamodb_table
              }
            }
          ]
        }
        # Read more here: https://github.com/grafana/loki/tree/master/docs/configuration#storage_config
        storage_config = {
          aws = {
            s3 = "s3://${module.s3_bucket.this_s3_bucket_region}/${module.s3_bucket.this_s3_bucket_id}"
            dynamodb = {
              dynamodb_url = "dynamodb://${data.aws_region.loki.name}"
              metrics = {
                url : "http://prometheus-server.kube-system.svc.cluster.local:9090"
              }
            }
          }
        }
        table_manager = {
          retention_deletes_enabled = true
          retention_period          = "720h"
          index_tables_provisioning = {
            provisioned_write_throughput = 1
            provisioned_read_throughput  = 1

            write_scale = {
              enabled      = true
              min_capacity = 1
              role_arn     = module.iam.this_iam_role_arn
            }
            read_scale = {
              enabled      = true
              min_capacity = 1
              role_arn     = module.iam.this_iam_role_arn
            }
          }
        }
      }
    }
  }
}

data aws_caller_identity "loki" {}
data aws_region "loki" {}

data "aws_iam_policy_document" "loki" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:PutObject",
      "s3:GetObject"
    ]
    resources = [module.s3_bucket.this_s3_bucket_arn, "${module.s3_bucket.this_s3_bucket_arn}/*"]
  }

  statement {
    actions   = ["dynamodb:ListTables"]
    resources = ["*"]
  }

  statement {
    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:DeleteItem",
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:ListTagsOfResource",
      "dynamodb:PutItem",
      "dynamodb:Query",
      "dynamodb:TagResource",
      "dynamodb:UntagResource",
      "dynamodb:UpdateItem",
      "dynamodb:UpdateTable",
      "dynamodb:CreateTable",
      "dynamodb:DeleteTable"
    ]

    resources = ["arn:aws:dynamodb:${data.aws_region.loki.name}:${data.aws_caller_identity.loki.account_id}:table/${local.dynamodb_table}*"]
  }

  statement {
    actions = [
      "application-autoscaling:DescribeScalableTargets",
      "application-autoscaling:DescribeScalingPolicies",
      "application-autoscaling:RegisterScalableTarget",
      "application-autoscaling:DeregisterScalableTarget",
      "application-autoscaling:PutScalingPolicy",
      "application-autoscaling:DeleteScalingPolicy"
    ]
    resources = ["*"]
  }

  statement {
    actions = [
      "iam:GetRole",
      "iam:PassRole"
    ]
    resources = [
      module.iam.this_iam_role_arn
    ]
  }


}

resource "aws_iam_role_policy" "loki" {
  count = var.enable ? 1 : 0

  name = local.role_name
  role = module.iam.this_iam_role_name

  policy = data.aws_iam_policy_document.loki.json
}

module "iam" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "2.14.0"


  create_role                   = var.enable
  role_name                     = module.s3_bucket.this_s3_bucket_id
  provider_url                  = local.provider_url
  oidc_fully_qualified_subjects = ["system:serviceaccount:${local.namespace}:loki"]

  tags = var.tags
}


module "s3_bucket" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  version       = "1.9.0"
  create_bucket = var.enable
  bucket_prefix = local.bucket_prefix
  acl           = "private"
  force_destroy = true

  versioning = {
    enabled = false
  }
  tags = var.tags

}

data "kubernetes_all_namespaces" "all" {}

resource "kubernetes_namespace" "this" {
  count = contains(data.kubernetes_all_namespaces.all.namespaces, local.namespace) ? 0 : 1

  metadata {
    name = local.namespace
  }
}

resource "helm_release" "loki" {
  count      = var.enable ? 1 : 0
  name       = local.release_name
  chart      = local.chart_name
  version    = local.chart_version
  repository = local.repository
  namespace  = local.namespace

  wait   = false
  values = [yamlencode(local.loki_values)]


  depends_on = [kubernetes_namespace.this]

  /*  set {
    name  = "loki.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.iam.this_iam_role_arn
  }*/
}
