terraform {
  required_version = "~>0.12"

  required_providers {
    aws  = "~>2.60"
    http = "~>1.2"
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  version = "~>1.11"

  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}

provider "helm" {
  version = "~>1.2"

  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.cluster.token
    load_config_file       = false
  }
}

data "aws_availability_zones" "available" {}

data "aws_region" "current" {}

locals {
  cluster_name = "test-eks-${random_id.suffix.hex}"
  oidc_issuer  = trimprefix(module.eks.cluster_oidc_issuer_url, "https://")

  # nginx servers will listen on these ports on the worker nodes
  ingress_controller_node_ports = {
    http  = 32080
    https = 32443
  }

  tags = {
    team = "odin-platform"
  }
}

resource "random_id" "suffix" {
  byte_length = 4
}

module "vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc?ref=v2.33.0"

  name                 = local.cluster_name
  cidr                 = "172.16.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24"]
  public_subnets       = ["172.16.4.0/24", "172.16.5.0/24", "172.16.6.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = merge(
    local.tags,
    {
      "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    }
  )

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}

module "lb" {
  source = "github.com/terraform-aws-modules/terraform-aws-alb?ref=v5.2.0"

  name               = "${local.cluster_name}-ext"
  load_balancer_type = "network"
  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.public_subnets

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "TCP"
      target_group_index = 0
    },
    {
      port               = 443
      protocol           = "TCP"
      target_group_index = 1
    },
  ]

  target_groups = [
    {
      name_prefix      = "http"
      backend_protocol = "TCP"
      backend_port     = local.ingress_controller_node_ports.http
      target_type      = "instance"
    },
    {
      name_prefix      = "https"
      backend_protocol = "TCP"
      backend_port     = local.ingress_controller_node_ports.https
      target_type      = "instance"
    },
  ]

  tags = local.tags
}

resource "aws_security_group" "worker_http_ingress" {
  name_prefix = "${local.cluster_name}-ingress-http-"
  description = "Allows HTTP access from anywhere to the ingress NodePorts"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "HTTP from NLB"
    from_port   = local.ingress_controller_node_ports.http
    to_port     = local.ingress_controller_node_ports.http
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}

resource "aws_security_group" "worker_https_ingress" {
  name_prefix = "${local.cluster_name}-ingress-https-"
  description = "Allows HTTPS access from anywhere to the ingress NodePorts"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "HTTPS from NLB"
    from_port   = local.ingress_controller_node_ports.https
    to_port     = local.ingress_controller_node_ports.https
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}

module "eks" {
  source = "github.com/terraform-aws-modules/terraform-aws-eks?ref=v12.0.0"

  cluster_name    = local.cluster_name
  cluster_version = "1.16"

  enable_irsa = true
  vpc_id      = module.vpc.vpc_id
  subnets     = module.vpc.private_subnets

  worker_groups_launch_template = [
    {
      platform                = "linux"
      asg_max_size            = 1
      asg_min_size            = 1
      asg_desired_capacity    = 1
      override_instance_types = ["t3.large"]
      spot_instance_pools     = 1

      target_group_arns = module.lb.target_group_arns

      additional_security_group_ids = [
        aws_security_group.worker_http_ingress.id,
        aws_security_group.worker_https_ingress.id,
      ]
    },
  ]

  tags = local.tags
}

module "addons" {
  source = "../../modules/cluster-autoscaler"

  cluster_name         = module.eks.cluster_id
  oidc_provider_issuer = local.oidc_issuer
  oidc_provider_arn    = module.eks.oidc_provider_arn
}
