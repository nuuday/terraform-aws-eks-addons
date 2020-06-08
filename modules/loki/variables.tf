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

variable "persistence_size" {
  type        = string
  default     = "10Gi"
  description = "Available disk space"
}

variable "resources_request_cpu" {
  type        = string
  default     = "100m"
  description = "Requested cpu resources for loki"
}

variable "resources_request_memory" {
  type        = string
  default     = "256Mi"
  description = "Requested memory resources for loki"
}

variable "cluster_name" {
  description = "Name of the EKS cluster to deply Loki into."
  type        = string
}


variable "oidc_provider_issuer_url" {
  description = "Issuer used in the OIDC provider associated with the EKS cluster to support IRSA."
  type        = string
}

variable "tags" {
  description = "Tags to apply to taggable resources provisioned by this module."
  type        = map(string)
  default     = {}
}