# region = "sgp1"
# ip_range = "10.20.0.0/20"
data "digitalocean_vpc" "beatbuddy-sgp-vpc" {
  name = "beatbuddy-sgp-vpc"
}
