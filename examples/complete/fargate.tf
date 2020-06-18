resource "aws_eks_fargate_profile" "sample" {
  cluster_name           = module.eks.cluster_id
  fargate_profile_name   = "sample"
  pod_execution_role_arn = aws_iam_role.sample_fargate.arn
  subnet_ids             = module.vpc.private_subnets

  selector {
    namespace = "sample"
  }
}

resource "aws_iam_role" "sample_fargate" {
  name = "${module.eks.cluster_id}-sample-fargate"

  assume_role_policy = data.aws_iam_policy_document.fargate.json
}

data "aws_iam_policy_document" "fargate" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks-fargate-pods.amazonaws.com"]
    }
  }
}
