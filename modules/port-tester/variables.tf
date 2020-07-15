variable "chart_version" {
  default     = "0.1.0"
  description = "port-testing version to install"
  type        = string
}

variable "namespace" {
  description = "Namespace to install port-tester in"
  type        = string
}

variable "enable" {
  default     = false
  description = "Enable or Disable port-testing"
  type        = bool
}

variable "create_namespace" {
  description = "Whether to create the namespace defined in the namespace variable. Will fail if the namespace already exists"
  default     = false
}