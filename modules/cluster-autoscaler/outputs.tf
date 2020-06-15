output "asg_tags" {
  description = "Tags which must be added to the auto-scaling groups for the cluster-autoscaler to consider."
  value       = local.asg_tags
}
