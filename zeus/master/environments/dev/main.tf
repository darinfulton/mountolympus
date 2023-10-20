locals {
  env_name = "${var.project_name}-${var.environment}-${replace(var.eks_version, ".", "-")}"
}

module "vpc" {
  source = "./networking"

  vpc_params = var.vpc_params
  project_name = var.project_name
  env_name = local.env_name
}