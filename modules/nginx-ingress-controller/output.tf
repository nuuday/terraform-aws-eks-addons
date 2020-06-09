output "vpc_public_subnet_eks_ingress_tags" {
  description = "Tags for public subnets in the VPC to use for integration with EKS."
  value = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared",
    "kubernetes.io/role/elb"                    = "1"
  }
}

output "vpc_internal_subnet_eks_ingress_tags" {
  description = "Tags for internal subnets in the VPC to use for integration with EKS."
  value = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared",
    "kubernetes.io/role/internal-elb"           = "1"
  }
}
