provider "aws" {
  profile = "default"
  region  = "us-east-1"
    assume_role {
      role_arn = "arn:aws:iam:573745071264:role/tf-admin"
    }
}

provider "kubernetes" {
  host = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command = "aws"
      args = ["--profile", "tf-admin", "eks", "get-token", "--cluster-name", module.eks.cluster_name]
    }
}