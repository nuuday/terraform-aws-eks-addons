variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster to deploy addons to. This variable will be passed on to all addons."
}

variable "tags" {
  default     = {}
  type        = map(string)
  description = "Tags to add to resources. This variable will be passed on to all addons."
}

variable "aws_node_termination_handler" {
  type = any
  default = {}
}

variable "cert_manager" {
  type = any
  default = {}
}

variable "cilium" {
  type = any
  default = {}
}

variable "cluster_autoscaler" {
  type = any
  default = {}
}

variable "external_dns" {
  type = any
  default = {}
}

variable "kube_monkey" {
  type = any
  default = {}
}

variable "loki" {
  type = any
  default = {}
}

variable "metrics_server" {
  type = any
  default = {}
}

variable "prometheus" {
  type = any
  default = {}
}