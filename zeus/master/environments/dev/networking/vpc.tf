data "aws_availability_zones" "available" {
  state = "available"
}



#########################
#  Subnet CIDR Blocks   #
#########################

module "subnet_addrs" {
  source = "hashicorp/subnets/cidr"
  version = "1.0.0"

  base_cidr_block = var.vpc_params.vpc_cidr
  networks = [
    {
        name        = "public-1"
        new_bits    = 4
    },
    {
        name        = "public-2"
        new_bits    = 4
    },
    {
        name        = "private-1"
        new_bits    = 4
    },
    {
        name        = "private-2"
        new_bits    = 4
    },
    {
        name        = "intra-1"
        new_bits    = 8
    },
    {
        name        = "intra-2"
        new_bits    = 8
    },
  ]
}

##################
#   VPC Module   #
##################

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = "${var.env_name}-vpc"
  cidr = var.vpc_params.vpc_cidr

  azs                 = data.aws_availability_zones.available.names
  private_subnets     = [module.subnet_addrs.network_cidr_blocks["private-1"], module.subnet_addrs.network_cidr_blocks["private-2"]]
  public_subnets      = [module.subnet_addrs.network_cidr_blocks["public-1"], module.subnet_addrs.network_cidr_blocks["public-2"]]
  intra_subnets       = [module.subnet_addrs.network_cidr_blocks["intra-1"], module.subnet_addrs.network_cidr_blocks["intra-2"]]

  private_subnet_names = ["Private Subnet One", "Private Subnet Two"]
  public_subnet_names  = ["Public Subnet One", "Public Subnet Two"]
  intra_subnet_names   = ["Intra Subnet One", "Intra Subnet Two"]

  enable_dns_hostnames = var.vpc_params.enable_dns_hostnames
  enable_dns_support   = var.vpc_params.enable_dns_support

  enable_nat_gateway = var.vpc_params.enable_nat_gateway
  single_nat_gateway = var.vpc_params.single_nat_gateway
  enable_vpn_gateway = var.vpc_params.enable_vpn_gateway

}

#####################
#   VPC Endpoints   #
#####################

module "endpoints" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "~> 5.1.1"

  vpc_id = module.vpc.vpc_id

  create_security_group = true
  
  security_group_description = "VPC endpoint security group"
  security_group_rules = {
    ingress_https = {
        description = "HTTPS from VPC"
        cidr_blocks = [module.vpc.vpc_cidr_block]
    }
  }

  endpoints = {
    dynamodb = {
        service = "dynamodb"
        service_type = "Gateway"
        route_table_ids = flatten([module.vpc.intra_route_table_ids, module.vpc.private_route_table_ids, module.vpc.public_route_table_ids])
        
            tags = { Name = "${var.env_name}-vpc-ddb-ep"}
    },
    s3 = {
        service = "s3"
        service_type = "Gateway"
        route_table_ids = flatten([module.vpc.intra_route_table_ids, module.vpc.private_route_table_ids, module.vpc.public_route_table_ids])

            tags = { Name = "${var.env_name}-vpc-s3-ep"}
    },
    sts = {
        service = "sts"
        private_dns_enabled = true
        subnet_ids = module.vpc.private_subnets

            tags = { Name = "${var.env_name}-vpc-sts-ep"}
    },
    ecr_api = {
        service = "ecr.api"
        private_dns_enabled = true
        subnet_ids = module.vpc.private_subnets

            tags = { Name = "${var.env_name}-vpc-ecr-api-ep"}
    },
    ecr_dkr = {
        service = "ecr.dkr"
        private_dns_enabled = true
        subnet_ids = module.vpc.private_subnets

            tags = { Name = "${var.env_name}-vpc-ecr-dkr-ep"}
    }
  }

}


