
locals {
  location = var.regional ? var.region : var.zones[0]
  node_locations = var.regional ? coalescelist(compact(var.zones), sort(random_shuffle.available_zones.result)) : slice(var.zones, 1, length(var.zones))
  region   = var.regional ? var.region : join("-", slice(split("-", var.zones[0]), 0, 2))
  cluster_type                = var.regional ? "regional" : "zonal"
}