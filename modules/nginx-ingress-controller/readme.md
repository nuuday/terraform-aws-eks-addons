This terraform module deploy a Nginx Ingress Controller on an EKS cluster.

## Prerequisites
- This module uses the kubernetes.
- This module uses the helm provider.

## Usage example
```
data "aws_eks_cluster" "this" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.this.token
  load_config_file       = false
  version                = "~> 1.9"
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.this.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.this.token
    load_config_file       = false
  }
}


module "ingress_controller" {
  source = "..\\terraform-aws-eks-addons\\modules\\nginx-ingress-controller"
  cluster_name = module.eks.cluster_id
  lb_fqdn =  module.lb.this_lb_dns_name
}
```
