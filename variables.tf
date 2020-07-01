variable "eks_endpoint" {
  type        = string
  description = "The hostname (in form of URI) of Kubernetes master. Can be sourced from the aws_eks_cluster data block: data.aws_eks_cluster.cluster.endpoint"
}

variable "eks_cluster_ca_certificate" {
  type        = string
  description = "PEM-encoded root certificates bundle for TLS authentication. Can be sourced from the aws_eks_cluster data block: base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)"
}

variable "eks_token" {
  type        = string
  description = "Token of your service account. Can be sourced from the aws_eks_cluster_auth data block: data.aws_eks_cluster_auth.cluster.token"
}

variable "tags" {
  default     = {}
  type        = map(string)
  description = "Map of tags to add to resources. This variable will be passed on to all resources where applicable."
}

variable "aws_node_termination_handler" {
  type    = any
  default = {}
}

variable "cert_manager" {
  type    = any
  default = {}
}

variable "cilium" {
  type    = any
  default = {}
}

variable "cluster_autoscaler" {
  type    = any
  default = {}
}

variable "external_dns" {
  type    = any
  default = {}
}

variable "kube_monkey" {
  type    = any
  default = {}
}

variable "loki" {
  type    = any
  default = {}
}

variable "metrics_server" {
  type    = any
  default = {}
}

variable "nginx-ingress-controller" {
  type    = any
  default = {}
}

variable "prometheus" {
  type    = any
  default = {}
}