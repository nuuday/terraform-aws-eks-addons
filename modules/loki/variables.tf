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

variable "create_namespace" {
  description = "Whether to create the namespace defined in the namespace variable. Will fail if the namespace already exists."
  default     = false
}

variable "oidc_provider_issuer_url" {
  description = "Issuer used in the OIDC provider associated with the EKS cluster to support IRSA."
  type        = string
}

variable "values_overrides" {
  description = "Helm Chart values which will override defaults."
  type        = map
  default     = {}
}

variable "tags" {
  description = "Tags to apply to taggable resources provisioned by this module."
  type        = map(string)
  default     = {}
}