variable "cert_manager_enable" {
  default     = false
  description = "Enable cert-manager"
}

variable "cluster_autoscaler_enable" {
  default     = false
  description = "Enable cluster-autoscaler"
}

variable "cluster_autoscaler_cluster_name" {
  description = "Name of the EKS cluster to deply cluster-autoscaler into."
  type        = string
}

variable "cluster_autoscaler_chart_version" {
  description = "Version of the cluster-autoscaler chart to deploy. Must match the version of EKS. See https://github.com/helm/charts/tree/master/stable/cluster-autoscaler."
  default     = "7.0.0"
}

variable "cluster_autoscaler_enable" {
  description = "Whether to actually deploy the cluster-autoscaler."
  default     = true
}

variable "cluster_autoscaler_asg_tags" {
  description = "The tags to look for when detecting Auto-Scaling Groups. Defaults are documented here: https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler/cloudprovider/aws#auto-discovery-setup."
  type        = map(string)
  default     = {}
}

variable "cluster_autoscaler_oidc_provider_issuer" {
  description = "Issuer used in the OIDC provider associated with the EKS cluster to support IRSA."
  type        = string
}

variable "cluster_autoscaler_oidc_provider_arn" {
  description = "ARN of the OIDC provider associated with the EKS cluster to support IRSA."
  type        = string
}

variable "cluster_autoscaler_tags" {
  description = "Tags to apply to taggable resources provisioned by this module."
  type        = map(string)
  default     = {}
}

variable "external_dns_enable" {
  default     = false
  description = "Enable external-dns"
}

