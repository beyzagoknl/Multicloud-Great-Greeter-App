# Network Endpoint Groups (NEGs) for Cloud Run services
resource "google_compute_region_network_endpoint_group" "frontend_neg" {
  name                  = "${var.project_name}-frontend-neg"
  region                = var.gcp_region
  network_endpoint_type = "SERVERLESS"

  cloud_run {
    service = google_cloud_run_v2_service.frontend.name
  }

  depends_on = [
    google_cloud_run_v2_service.frontend,
    google_project_service.compute
  ]
}

resource "google_compute_region_network_endpoint_group" "backend_neg" {
  name                  = "${var.project_name}-backend-neg"
  region                = var.gcp_region
  network_endpoint_type = "SERVERLESS"

  cloud_run {
    service = google_cloud_run_v2_service.backend.name
  }

  depends_on = [
    google_cloud_run_v2_service.backend,
    google_project_service.compute
  ]
}

# Backend services for frontend NEGs
resource "google_compute_backend_service" "frontend_bs" {
  name                  = "${var.project_name}-frontend-bs"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  protocol              = "HTTP"

  backend {
    group = google_compute_region_network_endpoint_group.frontend_neg.id
  }
}

# Backend services for backend NEGs
resource "google_compute_backend_service" "backend_bs" {
  name                  = "${var.project_name}-backend-bs"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  protocol              = "HTTP"

  backend {
    group = google_compute_region_network_endpoint_group.backend_neg.id
  }
}

# URL map to route traffic
resource "google_compute_url_map" "this" {
  name = "${var.project_name}-urlmap"

  # default: frontend
  default_service = google_compute_backend_service.frontend_bs.id

  host_rule {
    hosts        = ["*"]
    path_matcher = "main"
  }

  path_matcher {
    name            = "main"
    default_service = google_compute_backend_service.frontend_bs.id

    # /api/* → backend
    path_rule {
      paths   = ["/api/*"]
      service = google_compute_backend_service.backend_bs.id
    }
  }
}

# HTTP proxy to route requests
resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "${var.project_name}-http-proxy"
  url_map = google_compute_url_map.this.id
}

# Global forwarding rule for HTTP traffic
resource "google_compute_global_forwarding_rule" "http_rule" {
  name       = "${var.project_name}-http-rule"
  target     = google_compute_target_http_proxy.http_proxy.id
  port_range = "80"
  ip_protocol = "TCP"
}