output "tags" {
  value = var.tags
}

output "aws_node_termination_handler" {
  value = module.aws_node_termination_handler
}

output "nginx_ingress_controller" {
  value = module.nginx_ingress_controller
}