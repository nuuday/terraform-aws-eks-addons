terraform {
  required_version = "> 0.12.0"
}

provider "aws" {
  version = "~> 2.0"
  region  = "eu-central-1"
}

module "aws_node_termination_handler" {
  source        = "./modules/aws-node-termination-handler"
  cluster_name  = var.cluster_name
  chart_version = var.aws_node_termination_handler.chart_version
  enable        = var.aws_node_termination_handler.enable
  namespace     = var.aws_node_termination_handler.namespace
}

# module "cert_manager" {
#   source       = "./modules/cert-manager"
#   cert_manager = var.cert_manager
# }

module "cilium" {
  source        = "./modules/cilium"
  cluster_name  = var.cluster_name
  chart_version = var.cilium.chart_version
  enable        = var.cilium.enable
  namespace     = var.cilium.namespace
  cluster_id    = var.cilium.cluster_id
}

module "cluster_autoscaler" {
  source                   = "./modules/cluster-autoscaler"
  cluster_name             = var.cluster_name
  tags                     = var.tags
  enable                   = var.cluster_autoscaler.enable
  asg_tags                 = var.cluster_autoscaler.asg_tags
  chart_version            = var.cluster_autoscaler.chart_version
  oidc_provider_issuer_url = var.cluster_autoscaler.oidc_provider_issuer_url
  oidc_provider_arn        = var.cluster_autoscaler.oidc_provider_arn
}

# module "external_dns" {
#   source       = "./modules/external-dns"
#   external_dns = var.external_dns
# }

module "kube_monkey" {
  source       = "./modules/kube-monkey"
  cluster_name = var.cluster_name
  enable       = var.kube_monkey.enable
  namespace    = var.kube_monkey.namespace
  dry_run      = var.kube_monkey.dry_run
  run_hour     = var.kube_monkey.run_hour
  start_hour   = var.kube_monkey.start_hour
  end_hour     = var.kube_monkey.end_hour
  timezone     = var.kube_monkey.timezone
}

module "loki" {
  source                   = "./modules/loki"
  cluster_name             = var.cluster_name
  enable                   = var.loki.enable
  chart_version            = var.loki.chart_version
  namespace                = var.loki.namespace
  persistence_size         = var.loki.persistence_size
  resources_request_cpu    = var.loki.resources_request_cpu
  resources_request_memory = var.loki.resources_request_memory
}

module "metrics_server" {
  source        = "./modules/metrics-server"
  cluster_name  = var.cluster_name
  chart_version = var.metrics_server.chart_version
  enable        = var.metrics_server.enable
  namespace     = var.metrics_server.namespace
}

module "prometheus" {
  source                   = "./modules/prometheus"
  cluster_name             = var.cluster_name
  enable                   = var.prometheus.enable
  chart_version            = var.prometheus.chart_version
  namespace                = var.prometheus.namespace
  persistence_size         = var.prometheus.persistence_size
  resources_request_cpu    = var.prometheus.resources_request_cpu
  resources_request_memory = var.prometheus.resources_request_memory
}