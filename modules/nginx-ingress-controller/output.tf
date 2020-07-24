output "prometheus_alert_manager_rules" {
  value = [{
    name = "nginx-ingress-controller"
    rules = [
      {
        alert = "NginxIngressControllerTooMany500s"
        expr  = "100 * ( sum( nginx_ingress_controller_requests{status=~\"5.+\"} ) / sum(nginx_ingress_controller_requests) ) > 5"
        for   = "1m"
        labels = {
          severity = "critical"
        }
        annotations = {
          description : "Too many 5XXs"
          summary : "More than 5% of the all requests did return 5XX, this require your attention"
        }
      },
      {
        alert = "NginxIngressControllerTooMany400s"
        expr  = "100 * ( sum( nginx_ingress_controller_requests{status=~\"4.+\"} ) / sum(nginx_ingress_controller_requests) ) > 5"
        for   = "1m"
        labels = {
          severity = "critical"
        }
        annotations = {
          description : "Too many 4XXs"
          summary : "More than 5% of the all requests did return 4XX, this require your attention"
        }
      }
    ]
  }]
}

output "ingress_class" {
  value = local.values.controller.ingressClass
}
