output "region" {
  value       = var.region
  description = "Region"
}

output "project_id" {
  value       = var.project_id
  description = "Project ID"
}

output "kubernetes_cluster_name" {
  value       = google_container_cluster.cluster.name
  description = "Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = google_container_cluster.cluster.endpoint
  description = "Cluster Host"
}
