variable "chart_version" {
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