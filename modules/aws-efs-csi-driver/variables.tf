variable "chart_version" {
  default     = "0.1.0"
  description = "aws-efs-csi-driver version"
  type        = string
}

variable "enable" {
  default     = true
  description = "Whether aws-efs-csi-driver should be installed or not."
  type        = bool
}
