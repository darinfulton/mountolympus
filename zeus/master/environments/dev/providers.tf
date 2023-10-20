provider "aws" {
  profile = "default"
  region  = "us-east-1"
    assume_role {
      role_arn = "arn:aws:iam::573745071264:role/tf-admin"
    }
}