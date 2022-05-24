variable "name" {
  type        = string
  default     = ""
  description = "cluster name"
}

variable "nodes_per_az" {
  default     = 2
  description = "number of gke nodes per az"
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

variable "create_cluster_admin_role_for_users" {
  type        = bool
  default     = false
  description = "Binding cluster admin role for users"
}

variable "admin_users" {
  type        = list(map(string))
  description = "List of maps containing admin users"

  default = [
    {
      name = "bot@org.me"
    },
  ]
}

variable "grafana_helm_override" {
  type        = list(map(string))
  description = "List of maps containing helm override for grafana"

  default = [
    {
      name = "bot"
      value = "bot"
    },
  ]
}

variable "nginx_ingress_helm_override" {
  type        = list(map(string))
  description = "List of maps containing helm override for nginx ingress"

  default = [
    {
      name = "bot"
      value = "bot"
    },
  ]
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

variable "pods_secondary_ip_range_name" {
  type        = string
  default     = ""
  description = "description"
}

variable "services_secondary_ip_range_name" {
  type        = string
  default     = ""
  description = "description"
}


