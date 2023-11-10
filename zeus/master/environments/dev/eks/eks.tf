module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "~> 19.17.2"

  cluster_name = "${var.env_name}-cluster"
  cluster_version = var.eks_version
  cluster_endpoint_public_access = var.eks_params.cluster_endpoint_public_access

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }
  
  vpc_id                   = var.vpc_id
  subnet_ids               = var.private_subnets_id
  control_plane_subnet_ids = var.intra_subnets_id

  eks_managed_node_groups = {
    default = {
      min_size     = var.eks_managed_node_group_params.default_group.min_size
      max_size     = var.eks_managed_node_group_params.default_group.max_size
      desired_size = var.eks_managed_node_group_params.default_group.desired_size

      instance_types = var.eks_managed_node_group_params.default_group.instance_types
      capacity_type  = var.eks_managed_node_group_params.default_group.capacity_type
      labels = {
        Environment = var.environment
        GithubRepo  = "terraform-aws-eks"
        GithubOrg   = "terraform-aws-modules"
      }

      taints = var.eks_managed_node_group_params.default_group.taints

      update_config = {
        max_unavailable_percentage = var.eks_managed_node_group_params.default_group.max_unavailable_percentage
      }

      tags = {
      }
    }
  }

  # aws-auth configmap
  #manage_aws_auth_configmap = true
  #aws_auth_roles = TODO

  aws_auth_users = var.eks_aws_auth_users

  cluster_identity_providers = {
    sts = {
      client_id = "sts.amazonaws.com"
    }
  }
}