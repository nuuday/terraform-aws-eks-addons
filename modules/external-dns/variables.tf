variable "enable" {
  default     = true
  description = "Enable or Disable external-dns."
  type        = bool
}

variable "route53_zones" {
  type        = list(string)
  description = "List of Route53 zones for external-dns to work with. NOTE: This is mutually exclusive to 'route53_zone_ids'."
  default     = []
}

variable "route53_zone_ids" {
  type        = list(string)
  description = "List of Route53 zone IDs for external-dns to work with. NOTE: This is mutually exclusive to 'route53_zones'."
  default     = []
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

variable "prefer_cname" {
  description = "Prefers CNAME records over ALIAS records."
  default     = false
}

variable "tags" {
  description = "Tags to apply to taggable resources provisioned by this module."
  type        = map(string)
  default     = {}
}
