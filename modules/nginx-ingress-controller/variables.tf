
#-------------------------------------------------------------------------------
# MODULE PARAMETERS

# Theses variabels are expected to be passed in by the operator when caling this module
#-------------------------------------------------------------------------------


variable "lb_fqdn" {
  description = "the FQDN address to set as the load-balancer status of Ingress"
}


# Optional variables with default value
#-------------------------------------------------------------------------------

variable "enable" {
  type    = bool
  default = true

}


variable "nginx_ingress_chart_version" {
  description = "the nginx helm chart version"
  default     = "1.36.2"

}

variable "kubernetes_namespace" {
  description = "the namespace to create the ingress controller in default nginx-ingress"
  default     = "nginx-ingress"
}

variable "controller_service_nodeports_http" {
  description = "List of http ports that map Ingress's ports 80 to be open for service"
  default     = "32080"
}

variable "controller_service_nodeports_https" {
  description = "List of https ports that map Ingress's ports 443 to be open for service"
  default     = "32443"
}


