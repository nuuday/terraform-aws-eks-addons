variable "chart_version" {
  default     = "0.7.5"
  description = "AWS Node Termination handler version."
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

variable "wait" {
  description = "Whether to wait for the deployment of this add-on to succeed before completing."
  default     = true
}
