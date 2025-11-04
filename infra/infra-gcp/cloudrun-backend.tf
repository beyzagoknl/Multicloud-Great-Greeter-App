resource "google_cloud_run_v2_service" "backend" {
  name     = "${var.project_name}-backend"
  location = var.gcp_region
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = var.backend_image

      # Flask app 8080 port
      ports {
        container_port = 8080
      }

      env {
        name  = "PORT"
        value = "8080"
      }

      env {
        name  = "GREETINGS_FILE"
        value = "/app/greetings.txt"
      }
    }
  }

  depends_on = [
    google_project_service.run
  ]
} 