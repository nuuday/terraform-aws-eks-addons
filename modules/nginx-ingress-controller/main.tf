locals {
  chart_name    = "nginx-ingress"
  chart_version = var.chart_version
  release_name  = "nginx-ingress"
  namespace     = var.namespace
  repository    = "https://kubernetes-charts.storage.googleapis.com"

  http_ports = tomap({
    for listener in var.controller_service_node_ports :
    (listener.name) => listener
    if lower(listener.protocol) == "tcp" && contains([80, 443], listener.port)
  })

  enable_https = contains(keys(local.http_ports), "https")
  enable_http  = contains(keys(local.http_ports), "http")

  values = {
    controller = {
      ingressClass = "nginx"

      kind = var.controller_kind

      podAnnotations = {
        "prometheus.io/scrape" : "true"
        "prometheus.io/port" : "10254"
      }

      nodeSelector = merge(
        {
          "kubernetes.io/os" = "linux"
        },
        var.node_selectors
      )

      tolerations = var.tolerations

      metrics = {
        enabled = true
        port : 10254

        service = {
          annotations = {
            "prometheus.io/scrape" : "true"
            "prometheus.io/port" : "10254"
          }
        }
      }

      autoscaling = {
        enabled = true
      }

      resources = {
        limits = {
          memory = "128Mi"
        }

        requests = {
          cpu    = "100m"
          memory = "64Mi"
        }
      }

      service = {
        type = "NodePort"

        # Preserve the source IP for incoming requests
        # https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typenodeport
        externalTrafficPolicy = "Local"
        enableHttp            = local.enable_http
        enableHttps           = local.enable_https

        nodePorts = {
          http  = local.enable_http ? local.http_ports.http.nodePort : ""
          https = local.enable_https ? local.http_ports.https.nodePort : ""
          tcp = {
            for listener in var.controller_service_node_ports :
            (listener.nodePort) => listener.port
            if lower(listener.protocol) == "tcp" && ! contains([80, 443], listener.port)
          }
        }
      }

      extraArgs = {
        "publish-status-address" = var.loadbalancer_fqdn
      }
    }

    defaultBackend = {
      nodeSelector = {
        "kubernetes.io/os" = "linux"
      }
    }

    tcp = {
      for listener in var.controller_service_node_ports :
      (listener.port) => listener.name
      if lower(listener.protocol) == "tcp" && ! contains([80, 443], listener.port)
    }
  }
}

resource "kubernetes_namespace" "this" {
  count = var.create_namespace == true ? 1 : 0

  metadata {
    name = var.namespace

    labels = {
      role = "nginx_ingress"
    }

    annotations = {
      managedby = "terraform"
    }
  }
}

resource "helm_release" "nginx_ingress" {
  count            = var.enable ? 1 : 0
  name             = local.release_name
  chart            = local.chart_name
  version          = local.chart_version
  repository       = local.repository
  namespace        = local.namespace
  create_namespace = var.create_namespace
  wait             = true
  values           = [yamlencode(local.values)]
}
