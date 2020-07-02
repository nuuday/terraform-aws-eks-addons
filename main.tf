terraform {
  required_version = "> 0.12.0"
}

locals {
  default_namespace = "kube-system"
}

module "aws_node_termination_handler" {
  source = "./modules/aws-node-termination-handler"

  enable        = lookup(var.aws_node_termination_handler, "enable", "false")
  chart_version = lookup(var.aws_node_termination_handler, "chart_version", "0.7.5")
  namespace     = lookup(var.aws_node_termination_handler, "namespace", local.default_namespace)
}

module "nginx_ingress_controller" {
  source = "./modules/nginx-ingress-controller"

  enable                             = lookup(var.nginx_ingress_controller, "enable", "false")
  chart_version                      = lookup(var.nginx_ingress_controller, "chart_version", "1.36.2")
  namespace                          = lookup(var.nginx_ingress_controller, "namespace", local.default_namespace)
  lb_fqdn                            = lookup(var.nginx_ingress_controller, "lb_fqdn", null)
  controller_service_nodeports_http  = lookup(var.nginx_ingress_controller, "controller_service_nodeports_http", "32080")
  controller_service_nodeports_https = lookup(var.nginx_ingress_controller, "controller_service_nodeports_https", "32443")
}