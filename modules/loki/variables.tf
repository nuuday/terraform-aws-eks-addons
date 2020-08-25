variable "chart_version" {
  default     = "0.37.3"
  description = "Loki version to install"
  type        = string
}

variable "namespace" {
  description = "Namespace to install loki in"
  default     = "kube-system"
  type        = string
}

variable "enable" {
  default     = true
  description = "Enable or Disable loki."
  type        = bool
}

variable "cluster_name" {
  description = "Name of the EKS cluster to deply Loki into."
  type        = string
}


variable "oidc_provider_issuer_url" {
  description = "Issuer used in the OIDC provider associated with the EKS cluster to support IRSA."
  type        = string
}

variable "prometheus_uri" {
  description = "URI of Prometheus service complete with protocol and port."
  value       = "http://prometheus-server.kube-system.svc.cluster.local:9090"
}

variable "tags" {
  description = "Tags to apply to taggable resources provisioned by this module."
  type        = map(string)
  default     = {}
}
