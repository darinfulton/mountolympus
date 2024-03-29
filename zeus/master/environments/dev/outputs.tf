output "vpc_cidr" {
  value = var.vpc_params.vpc_cidr
}

output "env_name" {
  value = local.env_name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_public_subnets" {
  value = [module.vpc.network_cidr_blocks["public-1"], module.vpc.network_cidr_blocks["public-2"]]
}

output "vpc_private_subnets" {
  value = [module.vpc.network_cidr_blocks["private-1"], module.vpc.network_cidr_blocks["private-2"]]
}

output "vpc_intra_subnets" {
  value = [module.vpc.network_cidr_blocks["intra-1"], module.vpc.network_cidr_blocks["intra-2"]]
}