variable "cluster_name" {
  description = "Name of the EKS cluster to deply AWS Node Termination handler into."
  type        = string
}

variable "chart_version" {
  default     = "0.7.5"
  description = "AWS Node Termination handler version"
  type        = string
}

variable "enable" {
  default     = true
  description = "Enable or Disable AWS Node Termination handler."
  type        = bool
}

variable "namespace" {
  default     = "kube-system"
  description = "Namespace to deploy AWS Node Termination handler in."
  type        = string
}