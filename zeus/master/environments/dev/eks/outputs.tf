<<<<<<< HEAD
output "eks_cloudwatch_log_group_arn" {
  value = module.eks.cloudwatch_log_group_arn
}
=======
#output "eks_cloudwatch_log_group_arn" {
# value = module.eks.cloudwatch_log_group_arn
#}
>>>>>>> 85bfa77a1b1445309449cc9bf77e9ea3deb5a226
output "eks_cluster_arn" {
  value = module.eks.cluster_arn
}
output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
output "eks_cluster_iam_role_arn" {
  value = module.eks.cluster_iam_role_arn
}
output "eks_cluster_oidc_issuer_url" {
  value = module.eks.cluster_oidc_issuer_url
}
output "eks_oidc_provider" {
  value = module.eks.oidc_provider
}
output "eks_oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}