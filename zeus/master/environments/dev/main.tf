locals {
  env_name = "${var.project_name}-${var.environment}-${replace(var.eks_version, ".", "-")}"
}

module "vpc" {
  source = "./networking"

  vpc_params = var.vpc_params
  project_name = var.project_name
  env_name = local.env_name
<<<<<<< HEAD
=======
  environment = var.environment
>>>>>>> 85bfa77a1b1445309449cc9bf77e9ea3deb5a226
}

module "eks" {
  source = "./eks"

  eks_version = var.eks_version
  eks_params = var.eks_params
  eks_managed_node_group_params = var.eks_managed_node_group_params
  eks_aws_auth_users = var.eks_aws_auth_users
  vpc_id = module.vpc.vpc_id
  private_subnets_id = module.vpc.private_subnets_id
  intra_subnets_id = module.vpc.intra_subnets_id
  project_name = var.project_name
  env_name = local.env_name
<<<<<<< HEAD
=======
  environment = var.environment
>>>>>>> 85bfa77a1b1445309449cc9bf77e9ea3deb5a226
}