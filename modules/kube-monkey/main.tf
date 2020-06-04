locals {
  chart_name   = "${path.module}/files/helm/kube-monkey-chart"
  release_name = "kube-monkey"
  namespace    = var.namespace
  repository   = "https://kubernetes-charts.storage.googleapis.com"
}

resource "helm_release" "kube-monkey" {
  count     = var.enable ? 1 : 0
  name      = local.release_name
  chart     = local.chart_name
  namespace = local.namespace
  wait      = false


  set {
    name  = "config.dryRun"
    value = var.dry_run
  }

  set {
    name  = "config.runHour"
    value = var.run_hour
  }

  set {
    name  = "config.startHour"
    value = var.start_hour
  }
  set {
    name  = "config.endHour"
    value = var.end_hour
  }

  set {
    name  = "config.timeZone"
    value = var.timezone
    type  = "string"
  }

  set {
    name  = "config.debug.enabled"
    value = true
  }

  set {
    name  = "config.debug.schedule_immediate_kill"
    value = true
  }
}
