module "cert_manager" {
  count  = var.cert_manager_enable ? 1 : 0
  source = "./modules/cert-manager"
}
module "cluster_autoscaler" {
  count  = var.cluster_autoscaler_enable ? 1 : 0
  source = "./modules/cluster-autoscaler"
}
module "external_dns" {
  count  = var.external_dns_enable ? 1 : 0
  source = "./modules/external-dns"
}
