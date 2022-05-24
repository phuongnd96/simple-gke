data "google_compute_zones" "available" {
  provider = google

  project = var.project_id
  region  = local.region
}

resource "random_shuffle" "available_zones" {
  input        = data.google_compute_zones.available.names
  result_count = 3
}

locals {
  location = var.regional ? var.region : var.zones[0]
  node_locations = var.regional ? coalescelist(compact(var.zones), sort(random_shuffle.available_zones.result)) : slice(var.zones, 1, length(var.zones))
  region   = var.regional ? var.region : join("-", slice(split("-", var.zones[0]), 0, 2))
  cluster_type                = var.regional ? "regional" : "zonal"
}

# GKE cluster
resource "google_container_cluster" "primary" {
  provider = google
  name                      = var.name
  project                   = var.project_id
  location                  = local.location
  // use node_locations if provided, defaults to cluster level node_locations if not specified
  node_locations            = local.node_locations
  remove_default_node_pool  = var.remove_default_node_pool
  initial_node_count        = var.initial_node_count
  network                   = var.network
  subnetwork                = var.subnetwork
  lifecycle {
    ignore_changes = [node_pool, initial_node_count]
  }

}

resource "google_container_node_pool" "primary_nodes" {
  name                      = "general-pool"
  project                   = var.project_id
  # location                  = var.zones[0]
  node_locations            = var.zones
  cluster                   = "${google_container_cluster.primary.name}"
  node_count                = var.gke_num_nodes

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }

    machine_type = "n1-standard-1"
    tags         = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}
