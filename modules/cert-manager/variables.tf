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
  description = "If `install_clusterissuers = true`, then this e-mail address will be used for registering these with Let's Encrypt."
  default     = ""
}
variable "ingress_class" {
  type = string
}

variable "kubectl_server" {
  description = "Hostname of the EKS control plane. This will be passed to `kubectl --server $here`."
  type        = string
}

variable "kubectl_token" {
  type = string
}

variable "enable" {
  default     = true
  description = "enable or disable cert-manager"
  type        = bool
}

variable "install_clusterissuers" {
  description = "Whether to install ClusterIssuers"
  default     = true
}

variable "force_clusterissuers_recreate" {
  description = "If installing ClusterIssuers, this determines if they're recreated."
  default     = true
}

variable "namespace" {
  default     = "cert-manager"
  description = "Namespace to deploy cert-manager in."
  type        = string
}

variable "wait" {
  description = "Whether to wait for the deployment of this add-on to succeed before completing."
  default     = true
}
