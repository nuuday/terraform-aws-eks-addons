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
  type = object({
    cluster_name  = string
    chart_version = string
    enable        = bool
    namespace     = string
  })

  default = {
    cluster_name  = ""
    chart_version = "0.7.5"
    enable        = false
    namespace     = "kube-system"
  }
}

# variable "cert_manager" {
#   type = object({

#   })

#   default = {

#   }
# }

variable "cilium" {
  type = object({
    cluster_name  = string
    chart_version = string
    enable        = bool
    namespace     = string
    cluster_id    = number
  })

  default = {
    cluster_name  = ""
    enable        = false
    chart_version = "1.7.4"
    namespace     = "kube-system"
    cluster_id    = 1
  }
}

variable "cluster_autoscaler" {
  type = object({
    cluster_name             = string
    enable                   = bool
    tags                     = map(string)
    asg_tags                 = map(string)
    chart_version            = string
    oidc_provider_issuer_url = string
    oidc_provider_arn        = string
  })

  default = {
    cluster_name             = ""
    enable                   = false
    tags                     = {}
    asg_tags                 = {}
    chart_version            = "7.0.0"
    oidc_provider_issuer_url = ""
    oidc_provider_arn        = ""
  }
}

# variable "external_dns" {
#   type = object({

#   })

#   default = {

#   }
# }

variable "kube_monkey" {
  type = object({
    cluster_name = string
    enable       = bool
    namespace    = string
    dry_run      = bool
    run_hour     = number
    start_hour   = number
    end_hour     = number
    timezone     = string
  })

  default = {
    cluster_name = ""
    enable       = false
    namespace    = "kube-system"
    dry_run      = false
    run_hour     = 7
    start_hour   = 10
    end_hour     = 15
    timezone     = "Europe/Copenhagen"
  }
}

variable "loki" {
  type = object({
    cluster_name             = string
    chart_version            = string
    namespace                = string
    enable                   = bool
    persistence_size         = string
    resources_request_cpu    = string
    resources_request_memory = string
  })

  default = {
    cluster_name             = ""
    chart_version            = "0.37.3"
    namespace                = "kube-system"
    enable                   = false
    persistence_size         = "10Gi"
    resources_request_cpu    = "100m"
    resources_request_memory = "256Mi"
  }
}

variable "metrics_server" {
  type = object({
    cluster_name  = string
    chart_version = string
    enable        = bool
    namespace     = string
  })

  default = {
    cluster_name  = ""
    chart_version = "2.11.1"
    enable        = false
    namespace     = "kube-system"
  }
}

variable "prometheus" {
  type = object({
    cluster_name             = string
    chart_version            = string
    namespace                = string
    enable                   = bool
    persistence_size         = string
    retention                = string
    resources_request_cpu    = string
    resources_request_memory = string
  })

  default = {
    cluster_name             = ""
    chart_version            = "11.3.0"
    namespace                = "kube-system"
    enable                   = false
    persistence_size         = "10Gi"
    retention                = "720h"
    resources_request_cpu    = "100m"
    resources_request_memory = "256Mi"
  }
}