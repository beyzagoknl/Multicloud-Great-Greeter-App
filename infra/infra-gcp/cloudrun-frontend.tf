resource "google_cloud_run_v2_service" "frontend" {
  name     = "${var.project_name}-frontend"
  location = var.gcp_region
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = var.frontend_image

      # Nginx container 80
      ports {
        container_port = 80
      }

      #for env.js inside docker-entrypoint.sh 
      env {
        name  = "API_BASE_URL"
        value = "/api/"
      }
    }
  }

  depends_on = [
    google_project_service.run
  ]
}