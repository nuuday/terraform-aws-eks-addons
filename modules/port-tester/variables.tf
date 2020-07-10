variable "chart_version" {
  default     = "0.1.0"
  description = "port-testing version to install"
  type        = string
}

variable "namespace" {
  default     = "port-testing"
  description = "Namespace to install port-tester in"
  type        = string
}

variable "enable" {
  default     = false
  description = "Enable or Disable port-testing"
  type        = bool
}