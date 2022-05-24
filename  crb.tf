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
}