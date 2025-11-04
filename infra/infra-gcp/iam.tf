# Viewer role for developer
resource "google_project_iam_member" "developer_viewer" {
  project = var.gcp_project
  role    = "roles/viewer"
  member  = "user:${var.developer_email}"
}

# Cloud Run invoke access (developer)
resource "google_cloud_run_v2_service_iam_member" "frontend_invoker_developer" {
  project  = var.gcp_project
  location = var.gcp_region
  name     = google_cloud_run_v2_service.frontend.name
  role     = "roles/run.invoker"
  member   = "user:${var.developer_email}"
}

# Cloud Run invoke access (developer)
resource "google_cloud_run_v2_service_iam_member" "backend_invoker_developer" {
  project  = var.gcp_project
  location = var.gcp_region
  name     = google_cloud_run_v2_service.backend.name
  role     = "roles/run.invoker"
  member   = "user:${var.developer_email}"
}

# Public (unauthenticated) access to Cloud Run services:
resource "google_cloud_run_v2_service_iam_member" "frontend_invoker_public" {
  project  = var.gcp_project
  location = var.gcp_region
  name     = google_cloud_run_v2_service.frontend.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

# Public (unauthenticated) access to Cloud Run services:
resource "google_cloud_run_v2_service_iam_member" "backend_invoker_public" {
  project  = var.gcp_project
  location = var.gcp_region
  name     = google_cloud_run_v2_service.backend.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}