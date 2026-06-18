output "cluster_name" {
  value = module.eks.cluster_name
}

output "region" {
  description = "AWS region."
  value       = var.region
}
