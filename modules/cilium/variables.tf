variable "cluster_name" {
  description = "Cilium cluster name"
  type        = string
  default     = "cilium-cluster"
}

variable "enable" {
  default     = true
  description = "Enable or Disable cilium."
  type        = bool
}

variable "chart_version" {
  default     = "1.7.4"
  description = "Cilium version to install"
  type        = string
}

variable "namespace" {
  default     = "kube-system"
  description = "Kubernetes namespace to deploy to"
  type        = string
}

variable "cluster_id" {
  default     = "1"
  description = "Cilium cluster id"
  type        = number
}