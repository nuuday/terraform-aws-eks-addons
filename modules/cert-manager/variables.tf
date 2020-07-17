variable "chart_version" {
  default     = "0.15.1"
  description = "Cert-manager version"
  type        = string
}

variable "route53_zones" {
  type    = list(string)
  default = []
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

variable "email" {
  type = string
}
variable "ingress_class" {
  type = string
}

variable "kubectl_server" {
  type = string
}

variable "kubectl_token" {
  type = string
}

variable "enable" {
  default     = true
  description = "enable or disable cert-manager"
  type        = bool
}

variable "namespace" {
  default     = "cert-manager"
  description = "Namespace to deploy cert-manager in."
  type        = string
}
