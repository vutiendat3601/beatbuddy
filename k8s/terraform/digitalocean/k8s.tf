resource "digitalocean_kubernetes_cluster" "k8s" {
  name = "k8s"
  region = "sgp1"
  version = "1.29.1-do.0"
  node_pool {
    name       = "worker"
    size       = "s-2vcpu-2gb"
    node_count = 3
  }
}
