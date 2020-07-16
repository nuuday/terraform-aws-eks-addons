variable "enable" {
  default     = true
  description = "Enable or Disable external-dns."
  type        = bool
}

variable "route53_zone_ids" {
  type        = list(string)
  description = "List of Route53 zone IDs for external-dns to work with."
}

variable "chart_version" {
  default     = "3.2.3"
  description = "The version of external-dns to install."
  type        = string
}

variable "create_namespace" {
  description = "Whether to create the namespace defined in the namespace variable. Will fail if the namespace already exists."
  default     = false
}

variable "namespace" {
  default     = "kube-system"
  description = "Kubernetes namespace to deploy external-dns to."
  type        = string
}

variable "zone_type" {
  default     = "public"
  description = "DNS zone type, can be private or public."
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
