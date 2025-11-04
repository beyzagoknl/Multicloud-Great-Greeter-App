# Output the Cloud Run URL for the frontend service
output "frontend_cloud_run_url" {
  description = "Direct Cloud Run URL for the frontend service"
  value       = google_cloud_run_v2_service.frontend.uri
}

# Output the Cloud Run URL for the backend service
output "backend_cloud_run_url" {
  description = "Direct Cloud Run URL for the backend service"
  value       = google_cloud_run_v2_service.backend.uri
}

# Output the HTTP load balancer IP address
output "http_lb_ip" {
  description = "Global IP address of the HTTP load balancer"
  value       = google_compute_global_forwarding_rule.http_rule.ip_address
}