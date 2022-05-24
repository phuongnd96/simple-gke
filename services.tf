provider "helm" {
  kubernetes {
    # config_path = "~/.kube/config"
  host                   = "https://${google_container_cluster.primary.endpoint}"
#   token                  = "${google_container_cluster.primary.access_token}"
  token                  = "${data.google_client_config.default.access_token}"
  cluster_ca_certificate = "${base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)}"
  }
}

resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress-controller"
  count = var.deploy_nginx_ingress == true ? 1 : 0
  namespace  = var.nginx_ingress_ns
  create_namespace = true
  repository = var.nginx_ingress_chart_repository
  chart      = var.nginx_ingress_chart
  version    = var.nginx_ingress_chart_version
  atomic     = true
}

resource "helm_release" "grafana" {
  name       = "grafana"
  namespace  = var.grafana_ns
  create_namespace  = true
  count = var.deploy_grafana == true ? 1 : 0

  repository = var.grafana_chart_repository
  chart      = var.grafana_chart
  version    = var.grafana_chart_version
  atomic     = true
}