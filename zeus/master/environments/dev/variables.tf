variable "project_name" {
  description = "Project name to be used in resources"
  type = string
  default = "LrnTHIG"
}

variable "component" {
  description = "A team using this project (backend, web, ios, data, devops)"
  type = string
}

variable "environment" {
  description = "Dev/Prod tag to be used in AWS resources Name tag, and resources names"
  type = string
}

variable "eks_version" {
  description = "Kubernetes version that will be used in AWS resource names and to specify which EKS version to create/update"
  type = string
}

# Define VPC Parameters used during VPC creation
variable "vpc_params" {
  description = "VPC Parameters"
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

# Define EKS Parameters used during EKS creation
variable "eks_params" {
  description = "EKS Cluster Parameters"
  type = object({
    cluster_endpoint_public_access  = bool
#    cluster_enabled_log_types       = list(string) 
  })
}

#Define EKS Managed Node Group Parameters 
variable "eks_managed_node_group_params" {
  description = "EKS Managed Node Groups settings, one item in the map() per each dedicated Node Group"
  type = map(object({
    min_size                    = number
    max_size                    = number
    desired_size                = number
    instance_types              = list(string)
    capacity_type               = string
    taints                      = set(map(string))
    max_unavailable_percentage  = number 
  }))
}

variable "eks_aws_auth_users" {
  description = "IAM Users to be added to the aws-auth ConfigMap, one item in the set() per each IAM user"
  type = set(object({
    userarn = string
    username = string
    groups = list(string)
  }))
}