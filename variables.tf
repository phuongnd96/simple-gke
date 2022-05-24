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

variable "deploy_nginx_ingress" {
  type        = bool
  default     = false
  description = "Decide whether to deploy nginx-ingress or not"
}

variable "deploy_grafana" {
  type        = bool
  default     = false
  description = "Decide whether to deploy grafana or not"
}

variable "nginx_ingress_ns" {
  type        = string
  default     = ""
  description = "description"
}

variable "grafana_ns" {
  type        = string
  default     = ""
  description = "description"
}

variable "grafana_chart_version" {
  type        = string
  default     = ""
  description = "description"
}

variable "grafana_chart_repository" {
  type        = string
  default     = ""
  description = "description"
}

variable "grafana_chart" {
  type        = string
  default     = ""
  description = "description"
}

variable "nginx_ingress_chart_version" {
  type        = string
  default     = ""
  description = "description"
}

variable "nginx_ingress_chart_repository" {
  type        = string
  default     = ""
  description = "description"
}

variable "nginx_ingress_chart" {
  type        = string
  default     = ""
  description = "description"
}

