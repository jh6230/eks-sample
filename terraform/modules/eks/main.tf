# 参考
# https://zenn.dev/ring_belle/articles/kubernetes-eks-creating#%E5%86%85%E5%AE%B9

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.17"

  cluster_name    = var.cluster_name
  cluster_version = "1.28"

  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns                     = {}
    kube-proxy                  = {}
    vpc-cni                     = {}
    coredns = {
      configuration_values = jsonencode({
        computeType = "Fargate"
      })
    }
  }

  vpc_id                   = var.vpc_id
  subnet_ids               = var.private_subnets
  control_plane_subnet_ids = var.control_plane_subnet_ids

  create_cluster_security_group = false
  create_node_security_group    = false

  fargate_profile_defaults = {
    iam_role_additional_policies = {
      additional = aws_iam_policy.additional.arn
    }
  }

  # Fargate Profile
  fargate_profiles = merge(
    {
      sample-apps = {
        name = "sample-apps"
        selectors = [
          {
            namespace = "sample-apps"
          }
        ]
        subnet_ids = [var.private_subnets[0]]
      }
    },
    { for i in range(2) :
      "kube-system-${i}" => {
        selectors = [
          { namespace = "kube-system" }
        ]
        subnet_ids = [element(var.private_subnets, i)]
      }
    }
  )

  tags = {
    Terraform = "true"
  }

}

resource "aws_iam_policy" "additional" {
  name = "eks-sample-cluster-additional"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
