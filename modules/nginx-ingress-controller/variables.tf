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

variable "create_namespace" {
  description = "Whether to create the namespace defined in the namespace variable. Will fail if the namespace already exists"
  default     = false
}

variable "lb_fqdn" {
  type        = string
  description = "The FQDN address to set as the load-balancer status of Ingress"
}

variable "controller_service_nodeports_http" {
  description = "List of http ports that map Ingress's ports 80 to be open for service"
  default     = "32080"
}

variable "controller_service_nodeports_https" {
  description = "List of https ports that map Ingress's ports 443 to be open for service"
  default     = "32443"
}
