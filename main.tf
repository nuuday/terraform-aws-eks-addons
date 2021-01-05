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
