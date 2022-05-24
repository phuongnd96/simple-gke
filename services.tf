provider "helm" {
  kubernetes {
    # config_path = "~/.kube/config"
  host                   = "https://${google_container_cluster.primary.endpoint}"
#   token                  = "${google_container_cluster.primary.access_token}"
  token                  = "${google_client_config.default.access_token}"
  cluster_ca_certificate = "${base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)}"
  }
}

resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress-controller"
  count = var.deploy_nginx_ingress == true ? 1 : 0
  namespace  = "monitoring"
  create_namespace = true
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"
  version    = "4.1.1"
}

resource "helm_release" "grafana" {
  name       = "grafana"
  namespace  = "ingress-nginx"
  create_namespace  = true
  count = var.deploy_grafana == true ? 1 : 0

  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana/grafana"
  version    = "6.29.4"
}