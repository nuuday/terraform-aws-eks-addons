variable "enable" {
  description = "Enable or disable CAlico"
  default     = true
  type        = bool
}

variable "chart_version" {
  description = "Helm chart version"
  default     = "0.3.1"
  type        = string
}

variable "oidc_provider_issuer_url" {
  description = "Issuer used in the OIDC provider associated with the EKS cluster to support IRSA."
  type        = string
}

variable "create_namespace" {
  description = "Whether to create the namespace defined in the namespace variable. Will fail if the namespace already exists."
  default     = false
}

variable "namespace" {
  description = "Namespace to deploy cert-manager in."
  default     = "kube-system"
  type        = string
}

variable "values" {
  description = "Value override for Helm chart."
  default     = {}
  type        = any
}

variable "tags" {
  description = "Tags to apply to taggable resources provisioned by this module."
  type        = map(string)
  default     = {}
}

