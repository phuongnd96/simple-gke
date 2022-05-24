variable "name" {
  type        = string
  default     = ""
  description = "cluster name"
}

variable "gke_num_nodes" {
  default     = 2
  description = "number of gke nodes"
}

variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
}

variable "network" {
  type        = string
  description = "network"
}

variable "subnetwork" {
  type        = string
  description = "subnetwork"
}

variable "initial_node_count" {
  type        = string
  description = "initial_node_count"
  default = 1
}

variable "remove_default_node_pool" {
  type        = bool
  default     = false
  description = "remove_default_node_pool"
}

variable "regional" {
  type        = bool
  default     = false
  description = "determine the cluster is regional or zonal"
}

variable "zones" {
  type        = list(string)
  description = "The zones to host the cluster in (optional if regional cluster / required if zonal)"
  default     = ["asia-southeast1-a"]
}
