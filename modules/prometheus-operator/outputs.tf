output "server_url" {
  description = "URL of the deployed Prometheus server"
  value       = "http://prometheus-server.${local.namespace}.svc.cluster.local"
}
