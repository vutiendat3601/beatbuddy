# ip_range = "10.10.24.0/24" # CDIR
# region = "sgp1"
data "digitalocean_vpc" "beatbuddy-sgp-db-vpc" {
  name = "beatbuddy-sgp-db-vpc"
}
