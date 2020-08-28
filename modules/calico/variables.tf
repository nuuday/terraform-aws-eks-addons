variable "enable" {
  description = "Enable or disable Calico"
  default     = true
  type        = bool
}

variable "chart_version" {
  description = "Helm chart version"
  default     = "0.3.1"
  type        = string
}

variable "create_namespace" {
  description = "Whether to create the namespace defined in the namespace variable. Will fail if the namespace already exists."
  default     = false
}

variable "namespace" {
  description = "Namespace to deploy Calico in."
  default     = "kube-system"
  type        = string
}

variable "kubectl_server" {
  description = "Hostname of the EKS control plane. This will be passed to `kubectl --server $here`."
  type        = string
}

variable "kubectl_token" {
  type = string
}
