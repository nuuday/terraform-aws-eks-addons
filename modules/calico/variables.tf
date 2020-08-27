variable "enable" {
  description = "Enable or disable CAlico"
  default     = true
  type        = bool
}

variable "chart_version" {
  description = "Helm chart version"
  default     = "0.3.1"
  type        = string
}

variable "create_namespace" {
  description = "Whether to create the namespace defined in the namespace variable. Will fail if the namespace already exists."
  default     = false
}

variable "namespace" {
  description = "Namespace to deploy cert-manager in."
  default     = "kube-system"
  type        = string
}

variable "values" {
  description = "Value override for Helm chart."
  default     = {}
  type        = any
}

