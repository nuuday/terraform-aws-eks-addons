variable "chart_version" {
  default     = "2.11.1"
  description = "Metrics-server version"
  type        = string
}

variable "enable" {
  default     = true
  description = "Enable or Disable metrics-server."
  type        = bool
}

variable "namespace" {
  default     = "kube-system"
  description = "Namespace to deploy metrics-server in."
  type        = string
}