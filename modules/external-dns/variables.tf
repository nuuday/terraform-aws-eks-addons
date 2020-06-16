variable "enable" {
  default     = true
  description = "Enable or Disable external-dns."
  type        = bool
}

variable "chart_version" {
  default     = "1.7.4"
  description = "external dns version to install"
  type        = string
}

variable "namespace" {
  default     = "kube-system"
  description = "Kubernetes namespace to deploy to"
  type        = string
}

variable "zone_type" {
  default     = "public"
  description = "dns zone type, can be private or public"
}