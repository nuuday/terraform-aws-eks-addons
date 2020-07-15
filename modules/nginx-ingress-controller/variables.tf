variable "enable" {
  description = "Whether to actually deploy the nginx-ingress-controller"
  default     = true
}

variable "chart_version" {
  description = "Version of the nginx-ingress-controller chart to deploy"
  default     = "1.36.2"
}

variable "namespace" {
  description = "Namespace to deploy the nginx-ingress-controller to"
  default     = "kube-system"
}

variable "loadbalancer_fqdn" {
  type        = string
  description = "The FQDN address to set as the load-balancer status of Ingress"
}

variable "controller_service_node_ports" {
  type = list(object({
    name     = string
    port     = number
    nodePort = number
    protocol = string
  }))
  default = [
    { name = "http", nodePort = 32080, port = 80, protocol = "tcp" },
    { name = "https", nodePort = 32443, port = 443, protocol = "tcp" }
  ]
}

variable "create_namespace" {
  description = "Whether to create the namespace defined in the namespace variable. Will fail if the namespace already exists"
  default     = false
}