variable "tags" {
  default     = {}
  type        = map(string)
  description = "Map of tags to add to resources. This variable will be passed on to all resources where applicable."
}

variable "aws_node_termination_handler" {
  type    = any
  default = {}
}

variable "cert_manager" {
  type    = any
  default = {}
}

variable "cilium" {
  type    = any
  default = {}
}

variable "cluster_autoscaler" {
  type    = any
  default = {}
}

variable "external_dns" {
  type    = any
  default = {}
}

variable "kube_monkey" {
  type    = any
  default = {}
}

variable "loki" {
  type    = any
  default = {}
}

variable "metrics_server" {
  type    = any
  default = {}
}

variable "nginx_ingress_controller" {
  type    = any
  default = {}
}

variable "prometheus" {
  type    = any
  default = {}
}