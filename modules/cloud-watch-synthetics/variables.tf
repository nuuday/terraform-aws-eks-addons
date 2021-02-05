variable "enable" {
  default     = true
  description = "Enable or Disable CloudWatch Synthetics Ingress default backend test."
  type        = bool
}

variable "cluster_name" {
  description = "Name of the EKS cluster to run test against."
  type        = string
}

variable "retention_days" {
  description = "Number of days CloudWatch Synthetics will store logs."
  default     = 30
}

variable "tags" {
  description = "Tags to apply to taggable resources provisioned by this module."
  type        = map(string)
  default     = {}
}
