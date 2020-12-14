locals {
  chart_name    = "kube-prometheus-stack"
  chart_version = var.chart_version
  release_name  = "prometheus"
  namespace     = var.namespace
  repository    = "https://prometheus-community.github.io/helm-charts"

  prometheus_default_values = {
    fullnameOverride = "prometheus"
    alertmanager = {
      enabled = var.alertmanager_enabled
      alertmanagerSpec = {
        resources = {
          requests = {
            cpu    = "10m"
            memory = "32Mi"
          }
        }
        externalUrl = var.ingress_hostname != "" ? "https://${var.ingress_hostname}" : ""
      }
    }
    kubeProxy = {
      enabled = false
    }
    kubeControllerManager = {
      enabled = false
    }
    kubeScheduler = {
      enabled = false
    }
    grafana = {
      enabled = false
    }

    kubeStateMetrics = {
      enabled = true
    }
    "kube-state-metrics" = {
      resources = {
        requests = {
          cpu    = "10m"
          memory = "32Mi"
        }
      }
    }

    "prometheus-node-exporter" = {
      resources = {
        requests = {
          cpu    = "10m"
          memory = "32Mi"
        }
      }
    }

    prometheusOperator = {
      resources = {
        requests = {
          cpu    = "10m"
          memory = "32Mi"
        }
      }
    }

    prometheus = {
      ingress = {
        enabled     = var.ingress_enabled
        hosts       = [var.ingress_hostname]
        annotations = var.ingress_annotations
        labels      = var.ingress_labels
        tls = [{
          secretName = "prometheus-tls"
          hosts      = [var.ingress_hostname]
        }]
      }
      prometheusSpec = {
        retention = var.retention
        resources = var.prometheus_resources
        storageSpec = {
          volumeClaimTemplate = {
            spec = {
              storageClassName = "gp2"
              accessModes      = ["ReadWriteOnce"]
              resources = {
                requests = {
                  storage = var.persistence_size
                }
              }
            }
          }
        }
      }
    }
  }

  slack_globals = {
    alertmanager = {
      config = {
        global = {
          slack_api_url = var.slack_webhook
        }
        route = {
          group_by        = ["job"]
          group_wait      = "30s"
          group_interval  = "5m"
          repeat_interval = "12h"
          routes : [
            {
              match = {
                alertname = "DeadMansSwitch"
              }
              receiver = null
            },
            {
              receiver = "slack"
              match    = {}
              continue = true
            }
          ]
        }
        receivers = [
          { name = "null" },
          {
            name = "slack"
            slack_configs = [{
              title = <<EOF
[{{ .Status | toUpper }}{{ if eq .Status "firing" }}:{{ .Alerts.Firing | len }}{{ end }}] Monitoring Event Notification"
EOF
              text  = <<EOF
{{ range .Alerts }}
*Alert:* {{ .Annotations.summary }} - `{{ .Labels.severity }}`
*Description:* {{ .Annotations.description }}
*Graph:* <{{ .GeneratorURL }}|:chart_with_upwards_trend:> *Runbook:* <{{ .Annotations.runbook }}|:spiral_note_pad:>
*Details:*
{{ range .Labels.SortedPairs }} • *{{ .Name }}:* `{{ .Value }}`
{{ end }}
{{ end }}
EOF
            }]
          },
        ]
      }
    }
  }

  prometheus_values = concat([
    yamlencode(local.prometheus_default_values),
    yamlencode(var.slack_webhook != "" ? local.slack_globals : {}),
    yamlencode(var.helm_values)
  ],
  var.prometheus_config)
}

resource "kubernetes_namespace" "this" {
  count = var.create_namespace ? 1 : 0

  metadata {
    name = local.namespace
  }
}

resource "helm_release" "prometheus" {
  count      = var.enabled ? 1 : 0
  name       = local.release_name
  chart      = local.chart_name
  version    = local.chart_version
  repository = local.repository
  namespace  = local.namespace

  wait   = var.wait
  values = local.prometheus_values

  depends_on = [kubernetes_namespace.this]
}
