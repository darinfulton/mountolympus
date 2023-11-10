variable "vpc_params" {
  type = object({
    vpc_cidr                = string
    enable_nat_gateway      = bool
    one_nat_gateway_per_az  = bool
    single_nat_gateway      = bool
    enable_vpn_gateway      = bool
    enable_dns_hostnames    = bool
    enable_dns_support      = bool
  })
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}
variable "env_name" {
  type = string
}
