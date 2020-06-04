variable "chart_version" {
  default     = "11.3.0"
  description = "prometheus version to install"
  type        = string
}

variable "namespace" {
  default     = "kube-system"
  description = "Namespace to install prometheus in"
  type        = string
}


variable "enable" {
  default     = true
  description = "Enable or Disable prometheus."
  type        = bool
}

variable "persistence_size" {
  type        = string
  default     = "10Gi"
  description = "Available disk space"
}

variable "retention" {
  type        = string
  default     = "720h"
  description = "Retention period"
}


variable "resources_request_cpu" {
  type        = string
  default     = "100m"
  description = "Requested cpu resources for loki"
}

variable "resources_request_memory" {
  type        = string
  default     = "256Mi"
  description = "Requested memory resources for loki"
}
