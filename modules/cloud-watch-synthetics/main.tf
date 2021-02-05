locals {
  # bucket_prefix needs to be between 0 - 37 in length. Using cws rather than cloud-watch-synthetics to keep it short
  bucket_prefix         = "${var.cluster_name}-cws"
  bucket_name           = module.s3_bucket.this_s3_bucket_id
  role_name             = local.bucket_name
  synthetics_bucket_key = "${local.bucket_prefix}-${local.bucket_name}-canary-code"
}

data aws_caller_identity "cloud_watch_synthetics" {}
data aws_region "cloud_watch_synthetics" {}

data "aws_iam_policy_document" "cloud_watch_synthetics" {
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:GetBucketLocation"
    ]
    resources = [
      "${module.s3_bucket.this_s3_bucket_arn}/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:CreateLogGroup"
    ]

    # This is set to * as using the restricted resource caused the error, Lambda cannot assume the role. Cannot see where this error come from
    resources = [
      #"arn:aws:logs:${data.aws_region.cloud_watch_synthetics.name}:${data.aws_caller_identity.cloud_watch_synthetics.account_id}:log-group:*"
      "*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:ListAllMyBuckets",
      "xray:PutTraceSegments",
    ]
    resources = [
      "*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "cloudwatch:PutMetricData",
    ]
    resources = [
      "*"
    ]
    condition {
      test     = "StringEquals"
      variable = "cloudwatch:namespace"

      values = [
        "CloudWatchSynthetics"
      ]
    }
  }
}

data "aws_iam_policy_document" "sts_cloud_watch_synthetics" {
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [ "lambda.amazonaws.com" ]
    }
    actions = [ "sts:AssumeRole" ]
  }
}

resource "aws_iam_role" "cloud_watch_synthetics" {
  name               = local.bucket_name
  description        = "CloudWatch Synthetics lambda execution role for running canaries"
  assume_role_policy = data.aws_iam_policy_document.sts_cloud_watch_synthetics.json
  tags               = var.tags
  path               = "/service-role/"
}

resource "aws_iam_policy" "cloud_watch_synthetics" {
  name   = aws_iam_role.cloud_watch_synthetics.name
  policy = data.aws_iam_policy_document.cloud_watch_synthetics.json
}

resource "aws_iam_role_policy_attachment" "cloud_watch_synthetics" {
  role       = aws_iam_role.cloud_watch_synthetics.name
  policy_arn = aws_iam_policy.cloud_watch_synthetics.arn
}

module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "1.17.0"

  create_bucket = var.enable
  bucket_prefix = local.bucket_prefix
  acl           = "private"
  force_destroy = true

  versioning = {
    enabled = false
  }

  lifecycle_rule = [
    {
      id      = "retention"
      enabled = true
      prefix  = "/"

      expiration = {
        days = var.retention_days
      }
    }
  ]

  tags = var.tags
}

# NOTE: to destroy these resources you need to run terrform destroy. Terraform taint will not execute the "when = destroy" provisioner
# see: https://github.com/hashicorp/terraform/issues/14403
resource "null_resource" "code" {

  triggers = {
    s3_bucket_name = local.bucket_name
    s3_bucket_key = local.synthetics_bucket_key
  }

  # using cluster name + it (ingress test) for the name. This name is restricted to 21 characters so the naming can be a little tricky
  provisioner "local-exec" {
    command = "${path.module}/scripts/create-and-upload-code.sh -n ${var.cluster_name} -s ${self.triggers.s3_bucket_name} -k ${self.triggers.s3_bucket_key} -t ${jsonencode(var.tags)}"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "${path.module}/scripts/destroy-code.sh -s ${self.triggers.s3_bucket_name} -k ${self.triggers.s3_bucket_key}"
  }

  depends_on = [ module.s3_bucket, aws_iam_role.cloud_watch_synthetics ]
}

resource "null_resource" "cloud_watch_synthetics" {
  count      = var.enable ? 1 : 0

  triggers = {
    s3_bucket_name = local.bucket_name
    cluster_name="${var.cluster_name}-it"
  }

  # using cluster name + it (ingress test) for the name. This name is restricted to 21 characters so the naming can be a little tricky
  provisioner "local-exec" {
    command = "${path.module}/scripts/create-and-start-cloud-watch-synthetics.sh -n ${self.triggers.cluster_name} -s ${local.bucket_name} -k ${local.synthetics_bucket_key} -t ${jsonencode(var.tags)} -r ${aws_iam_role.cloud_watch_synthetics.arn}"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "${path.module}/scripts/destroy-cloud-watch-synthetics.sh -n ${self.triggers.cluster_name} -s ${self.triggers.s3_bucket_name}"
  }

  depends_on = [ null_resource.code, aws_iam_role.cloud_watch_synthetics ]
}