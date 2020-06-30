variable "chart_version" {
  default     = "1.36.2"
  description = "NGINX ingress controller version."
  type        = string
}

variable "enable" {
  default     = true
  description = "Enable or Disable NGINX ingress controller."
  type        = bool
}

variable "namespace" {
  default     = "kube-system"
  description = "Namespace to deploy NGINX ingress controller in."
  type        = string
}

# TODO: Add description and possibly change name
variable "lb_public_dns" {
}

# TODO: Add description and possibly change name
variable "ingress_controller_http" {
}

# TODO: Add description and possibly change name
variable "ingress_controller_https" {
}

# TODO: Add description
variable "common_tags" {
  type    = map
  default = {}
}