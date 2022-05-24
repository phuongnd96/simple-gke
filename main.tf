resource "random_shuffle" "available_zones" {
  input        = data.google_compute_zones.available.names
  result_count = 3
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
  ip_allocation_policy      = {
    cluster_secondary_range_name  = var.pods_secondary_ip_range_name
    services_secondary_range_name = var.services_secondary_ip_range_name
  }
  lifecycle {
    ignore_changes = [node_pool, initial_node_count]
  }

}

resource "google_container_node_pool" "primary_nodes" {
  name                      = "general-pool"
  project                   = var.project_id
  location                  = local.location
  # Override cluster node location, running workers accross azs
  node_locations            = var.zones
  cluster                   = "${google_container_cluster.primary.name}"
  node_count                = var.nodes_per_az

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/cloud-platform"
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
