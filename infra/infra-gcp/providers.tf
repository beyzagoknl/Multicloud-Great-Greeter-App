terraform {
  required_version = ">= 1.5.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
}

provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
}

# Enable required GCP services
resource "google_project_service" "run" {
  project = var.gcp_project
  service = "run.googleapis.com"
}

resource "google_project_service" "compute" {
  project = var.gcp_project
  service = "compute.googleapis.com"
}

resource "google_project_service" "iam" {
  project = var.gcp_project
  service = "iam.googleapis.com"
}
