locals {
  release_name = "cert-manager"
  chart_name   = "cert-manager"
  namespace    = var.namespace
  repository   = "https://charts.jetstack.io"
  provider_url = replace(var.oidc_provider_issuer_url, "https://", "")

  values = {
    resources = {
      requests = {
        cpu    = "10m"
        memory = "32Mi"
      }
    }
    webhook = {
      resources = {
        requests = {
          cpu    = "10m"
          memory = "32Mi"
        }
      }
    }
    cainjector = {
      resources = {
        requests = {
          cpu    = "10m"
          memory = "32Mi"
        }
      }
    }

    serviceAccount = {
      annotations = {
        "eks.amazonaws.com/role-arn" = module.iam.this_iam_role_arn
      }
    }
    securityContext = {
      enabled = true
    }
    nodeSelector = {
      "kubernetes.io/os" = "linux"
    }
    installCRDs = true
  }

  dns01_solver = {
    dns01 = {
      route53 = {
        region = data.aws_region.cert_manager.name
      }
    }
    selector = {
      dnsZones = var.route53_zones
    }
  }

  manifest_cluster_issuer_staging = {
    "apiVersion" = "cert-manager.io/v1alpha2"
    "kind"       = "ClusterIssuer"
    "metadata" = {
      name = "letsencrypt-staging"
    }
    spec = {
      acme = {
        email  = var.email
        server = "https://acme-staging-v02.api.letsencrypt.org/directory"
        privateKeySecretRef = {
          name = "acme-staging"
        }
        solvers = [
          {
            http01 = {
              ingress = {
                class = var.ingress_class
              }
            }
          },
          length(var.route53_zones) > 0 ? local.dns01_solver : null
        ]
      }
    }
  }

  manifest_cluster_issuer_production = {
    "apiVersion" = "cert-manager.io/v1alpha2"
    "kind"       = "ClusterIssuer"
    "metadata" = {
      name = "letsencrypt"
    }
    spec = {
      acme = {
        email  = var.email
        server = "https://acme-v02.api.letsencrypt.org/directory"
        privateKeySecretRef = {
          name = "acme-production"
        }
        solvers = [
          {
            http01 = {
              ingress = {
                class = var.ingress_class
              }
            }
          },
          length(var.route53_zones) > 0 ? local.dns01_solver : null
        ]
      }
    }
  }

}

data "aws_region" "cert_manager" {

}

data "aws_route53_zone" "cert_manager" {
  count = length(var.route53_zones)
  name  = var.route53_zones[count.index]
}

resource "random_id" "cert_manager" {
  keepers = {
    provider_url = local.provider_url
  }
  byte_length = 16
}

module "iam" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  create_role                   = var.enable
  role_name                     = "${local.release_name}-irsa-${random_id.cert_manager.hex}"
  provider_url                  = local.provider_url
  oidc_fully_qualified_subjects = ["system:serviceaccount:${local.namespace}:cert-manager"]
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
      for zone in data.aws_route53_zone.cert_manager :
      "arn:aws:route53:::hostedzone/${zone.zone_id}"
    ]
  }
  statement {
    actions = [
      "route53:ListHostedZonesByName"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "cert_manager" {
  count  = var.enable && length(var.route53_zones) > 0 ? 1 : 0
  name   = "cert-manager-${random_id.cert_manager.hex}"
  role   = module.iam.this_iam_role_name
  policy = data.aws_iam_policy_document.cert_manager.json
}

resource "helm_release" "cert_manager" {
  count            = var.enable ? 1 : 0
  name             = local.release_name
  chart            = local.chart_name
  version          = var.chart_version
  repository       = local.repository
  namespace        = local.namespace
  create_namespace = true
  wait             = true
  values           = [yamlencode(local.values)]
}

resource "time_sleep" "wait_30_seconds" {
  depends_on = [helm_release.cert_manager]

  create_duration = "30s"
}

// TODO: This needs to be changed with Terraform 0.13 when new kubernetes provider is available
resource "null_resource" "aws_iam_cluster_issuer" {
  count = var.enable ? 1 : 0
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = <<EOF
cat <<MOF | kubectl --token ${var.kubectl_token} apply -f -
${yamlencode(local.manifest_cluster_issuer_staging)}
MOF
EOF

    environment = {
      KUBECONFIG = "${var.kubeconfig_filename}"
    }
  }
  depends_on = [time_sleep.wait_30_seconds]
}

// TODO: This needs to be changed with Terraform 0.13 when new kubernetes provider is available
resource "null_resource" "aws_iam_cluster_issuer_production" {

  count = var.enable ? 1 : 0
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = <<EOF
cat <<MOF | kubectl --token ${var.kubectl_token} apply -f -
${yamlencode(local.manifest_cluster_issuer_production)}
MOF
EOF

    environment = {
      KUBECONFIG = "${var.kubeconfig_filename}"
    }
  }
  depends_on = [time_sleep.wait_30_seconds]

}