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

variable "values_override" {
  description = "Chart values which will override the default ones."
  default     = {}
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

variable "alertmanager_enable" {
  default     = true
  description = "Enable or disable alert manager"
  type        = bool
}

variable "alertmanager_alerts" {
  default     = []
  description = "Extra alert manager groups, see https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/ for syntax"
  type = list(object({
    name = string
    rules = list(object({
      alert       = string
      annotations = map(string)
      expr        = string
      for         = string
      labels      = map(string)
    }))
  }))
}

variable "pushgateway_enable" {
  default     = false
  description = "Enable or disable push gateway"
  type        = bool
}

variable "prometheus_config" {
  default = []
}
