data "google_compute_zones" "available" {
  provider = google

  project = var.project_id
  region  = local.region
}

data "google_client_config" "default" {}