output "aws_node_termination_handler" {
  value = module.aws_node_termination_handler
}

# output "cert_manager" {
#   value = module.cert_manager
# }

output "cilium" {
  value = module.cilium
}

output "cluster_autoscaler" {
  value = module.cluster_autoscaler
}

# output "external_dns" {
#   value = module.external_dns
# }

output "kube_monkey" {
  value = module.kube_monkey
}

output "loki" {
  value = module.loki
}

output "metrics_server" {
  value = module.metrics_server
}

output "prometheus" {
  value = module.prometheus
}