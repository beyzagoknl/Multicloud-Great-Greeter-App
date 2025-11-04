variable "gcp_project" {
  description = "GCP project ID to deploy into"
  type        = string
}

variable "gcp_region" {
  description = "GCP region for Cloud Run and NEGs"
  type        = string
  default     = "europe-west4"
}

variable "project_name" {
  description = "Project name prefix for resources"
  type        = string
  default     = "great-greeter"
}

variable "frontend_image" {
  description = "Artifact Registry image for the frontend (e.g. europe-west4-docker.pkg.dev/PROJECT/REPO/great-greeter-frontend:latest)"
  type        = string
}

variable "backend_image" {
  description = "Artifact Registry image for the backend (e.g. europe-west4-docker.pkg.dev/PROJECT/REPO/great-greeter-backend:latest)"
  type        = string
}

variable "developer_email" {
  description = "Developer that should see resources and invoke services"
  type        = string
  default     = "developer123@justeat.com"
}