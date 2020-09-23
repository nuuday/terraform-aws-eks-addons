variable "chart_version" {
  default     = "9.4.3"
  description = "prometheus-operator version to install"
  type        = string
}

variable "namespace" {
  default     = "kube-system"
  description = "Namespace to install prometheus in"
  type        = string
}

variable "create_namespace" {
  description = "Whether to create the namespace defined in the namespace variable. Will fail if the namespace already exists."
  default     = false
}

variable "enabled" {
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

variable "alertmanager_enabled" {
  default     = true
  description = "Enable or disable alert manager"
  type        = bool
}

variable "prometheus_resources" {
  description = "Specify prometheus server resource reservations"
  default = {
    requests = {
      cpu    = "300m"
      memory = "800Mi"
    }
  }
}

variable "prometheus_config" {
  default = []
}

variable "wait" {
  description = "Whether to wait for the deployment of this add-on to succeed before completing."
  default     = true
}

variable "slack_webhook" {
  description = "Provide a slack webhook, this configures slack notifications for prometheus alertmanager"
  type        = string
  default     = ""
}

variable "ingress_enabled" {
  description = "Enable ingress for prometheus"
  type        = bool
  default     = false
}

variable "ingress_hostname" {
  description = "Ingress hostname"
  type        = string
  default     = ""
}

variable "ingress_annotations" {
  description = "Ingress annotations"
  default     = {}
  type        = map
}

variable "ingress_labels" {
  description = "Ingress labels"
  default     = {}
  type        = object({})
}


