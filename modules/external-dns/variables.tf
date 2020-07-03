variable "enable" {
  default     = true
  description = "Enable or Disable external-dns."
  type        = bool
}

variable "route53_zones" {
  type = list(string)
}

variable "chart_version" {
  default     = "3.2.3"
  description = "external dns version to install"
  type        = string
}

variable "namespace" {
  default     = "kube-system"
  description = "Kubernetes namespace to deploy to"
  type        = string
}

variable "zone_type" {
  default     = "public"
  description = "dns zone type, can be private or public"
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