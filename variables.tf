variable "tags" {
  default     = {}
  type        = map
  description = "Map of tags to add to resources. This variable will be passed on to all resources where applicable."
}

variable "aws_node_termination_handler" {
  type    = any
  default = {}
}

variable "nginx_ingress_controller" {
  type    = any
  default = {}
}