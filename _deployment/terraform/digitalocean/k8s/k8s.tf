resource "digitalocean_kubernetes_cluster" "beatbuddy-sgp-k8s" {
  name = "beatbuddy-sgp-k8s"
  region = "sgp1"
  version = "1.29.1-do.0"
  vpc_uuid = data.digitalocean_vpc.beatbuddy-sgp-vpc.id
  node_pool {
    name       = "beatbuddy-sgp-k8s-worker"
    size       = "s-2vcpu-4gb"
    tags       = ["beatbuddy-sgp-k8s-worker"]
    node_count = 2
  }
}
