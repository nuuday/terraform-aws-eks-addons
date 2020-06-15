variable "alertmanager_enable" {
  default     = true
  description = "Enable or disable alert manager"
  type        = bool
}

variable "pushgateway_enable" {
  default     = false
  description = "Enable or disable push gateway"
  type        = bool
}

variable "prometheus_config" {
  default = []
}
locals {
  chart_name    = "prometheus"
  chart_version = var.chart_version
  release_name  = "prometheus"
  namespace     = var.namespace
  repository    = "https://kubernetes-charts.storage.googleapis.com"
  prometheus_default_values = {
    alertmanager = {
      enabled = var.alertmanager_enable
      resources = {
        requests = {
          cpu    = "10m"
          memory = "32Mi"
        }
      }
    }
    pushgateway = {
      enabled = var.pushgateway_enable
    }
    "kube-state-metrics" = {
      resources = {
        requests = {
          cpu    = "10m"
          memory = "32Mi"
        }
      }
    }
    nodeExporter = {
      resources = {
        requests = {
          cpu    = "10m"
          memory = "32Mi"
        }
      }
    }
    server = {
      retention        = var.retention
      persistentVolume = var.persistence_size
      resources = {
        requests = {
          cpu    = "50m"
          memory = "128Mi"
        }
      }
      global = {
        scrape_interval = "10s"
      }
      persistentVolume = {
        storageClass = "gp2"
      }
      statefulSet = {
        enabled = true
        headless = {
          servicePort = 9090
        }
      }
    }
    serverFiles = {
      "alerting_rules.yml"  = yamldecode(file("${path.module}/files/prometheus/prometheus_alerts.yaml"))
      "recording_rules.yml" = yamldecode(file("${path.module}/files/prometheus/prometheus_rules.yaml"))
    }
  }

  prometheus_values = concat([yamlencode(local.prometheus_default_values)], var.prometheus_config)

}

resource "helm_release" "prometheus" {
  count      = var.enable ? 1 : 0
  name       = local.release_name
  chart      = local.chart_name
  version    = local.chart_version
  repository = local.repository
  namespace  = local.namespace

  wait   = true
  values = local.prometheus_values

}
