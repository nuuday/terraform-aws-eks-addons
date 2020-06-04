variable "enabled" {
  default     = true
  description = "Enable or Disable kube-monkey."
  type        = bool
}

variable "namespace" {
  default     = "kube-system"
  description = "Namespace to install kube-monkey in"
  type        = string
}

variable "dry_run" {
  type        = bool
  default     = false
  description = "Do not actually kill anything"
}

variable "run_hour" {
  type        = number
  default     = "7"
  description = "Run hour"
}

variable "start_hour" {
  type        = number
  default     = "10"
  description = "Start hour"
}

variable "end_hour" {
  type        = number
  default     = "15"
  description = "Stop hour"
}
variable "timezone" {
  type        = string
  default     = "Europe/Copenhagen"
  description = "Timezone"
}
