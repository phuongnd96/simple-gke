provider "kubernetes" {
  host                   = "https://${google_container_cluster.primary.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = "${base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)}"
}

resource "kubernetes_cluster_role_binding" "cluster_admin" {
  metadata {
    name = "${var.name}-cluster-admin"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  dynamic "subject" {
    for_each = var.admin_users

    content {
        kind      = "User"
        name      = subject.value.name
        api_group = "rbac.authorization.k8s.io"
    }
  }
  depends_on = [
    google_container_cluster.primary,
    google_container_node_pool.primary_nodes
  ]
}