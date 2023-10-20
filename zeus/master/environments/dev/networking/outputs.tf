output "network_cidr_blocks" {
  value = module.subnet_addrs.network_cidr_blocks
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = [module.subnet_addrs.network_cidr_blocks["public-1"], module.subnet_addrs.network_cidr_blocks["public-2"]]
}

output "private_subnets" {
  value = [module.subnet_addrs.network_cidr_blocks["private-1"], module.subnet_addrs.network_cidr_blocks["private-2"]]
}

output "intra_subnets" {
  value = [module.subnet_addrs.network_cidr_blocks["intra-1"], module.subnet_addrs.network_cidr_blocks["intra-2"]]
}

output "public_subnets_id" {
  value = module.vpc.public_subnets
}

output "private_subnets_id" {
  value = module.vpc.private_subnets
}

output "intra_subnets_id" {
  value = module.vpc.intra_subnets
}


