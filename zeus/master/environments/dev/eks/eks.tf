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
<<<<<<< HEAD

      instance_types = var.eks_managed_node_group_params.default_group.instance_types
      capacity_type  = var.eks_managed_node_group_params.default_group.capacity_type
      labels = {
        Environment = "test"
=======
      ec2_ssh_key = module.key_pair.key_pair_name
      source_security_group_ids = [aws_security_group.remote_access.id]

      instance_types = var.eks_managed_node_group_params.default_group.instance_types
      capacity_type  = var.eks_managed_node_group_params.default_group.capacity_type


      labels = {
        Environment = var.environment
>>>>>>> 85bfa77a1b1445309449cc9bf77e9ea3deb5a226
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
<<<<<<< HEAD
=======
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"
  version = "~> 2.0"

  key_name = "id_rsa"
  public_key = trimspace(tls_private_key.this.public_key_openssh)
  create = false
}
resource "aws_security_group" "remote_access" {
  name_prefix = "${var.env_name}-remote-access"
  description = "Allow remote SSH access"
  vpc_id = var.vpc_id

  ingress {
    description = "SSH access"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["70.171.0.72/32"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
>>>>>>> 85bfa77a1b1445309449cc9bf77e9ea3deb5a226
}