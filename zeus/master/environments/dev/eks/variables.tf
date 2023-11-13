variable "project_name" {
  type = string
}

variable "env_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "eks_version" {
  type = string
}

# Define EKS Parameters used during EKS creation
variable "eks_params" {
  description = "EKS Cluster Parameters"
  type = object({
    cluster_endpoint_public_access  = bool
#    cluster_enabled_log_types       = list(string) 
  })
}

variable "vpc_id" {
  type = string
}

variable "private_subnets_id" {
  type = list(string)
}

variable "intra_subnets_id" {
  type = list(string)
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