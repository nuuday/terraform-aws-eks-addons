
variable "eks_cluster_name" {
    description = "the eks-clusrter name to install the ingress cotroller in"
    type = string
}

variable "lb_dns_name" {
    description = "Customized address to set as the load-balancer status of Ingress"
}

variable "kubernetes_namespace" {
  description = "the namespace to create the ingress controller in default nginx-ingress"
  default = "nginx-ingress"
}

variable "controller_service_nodeports_http" {
   description = "List of http ports that map Ingress's ports 80 to be open for service"
   default = "32080"
}

variable "controller_service_nodeports_https" {
   description = "List of https ports that map Ingress's ports 443 to be open for service"
   default = "32443"
}

variable "defaultBackend_nodeSelector" {
    description = "Node labels for pod assignment"
    default = "linux"
}

variable "nginx_ingress_chart_version" {
    description = "the nginx helm chart version"
    default = "1.36.2"
  
}


variable "ingress_controller_enable" {
   type = bool
   default = true
}



