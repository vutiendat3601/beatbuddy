resource "digitalocean_database_cluster" "beatbuddy-sgp-pg" {
  name                 = "beatbuddy-sgp-pg"
  region               = "sgp1"
  engine               = "pg"
  version              = "16"
  size                 = "db-s-1vcpu-2gb"
  node_count           = 1
  private_network_uuid = data.digitalocean_vpc.beatbuddy-sgp-db-vpc.id
}

resource "digitalocean_database_user" "beatbuddy" {
  cluster_id = digitalocean_database_cluster.beatbuddy-sgp-pg.id
  name       = "beatbuddy"
}

resource "digitalocean_database_db" "beatbuddy-user" {
  cluster_id = digitalocean_database_cluster.beatbuddy-sgp-pg.id
  name       = "beatbuddy_user"
}

resource "digitalocean_database_db" "beatbuddy-track" {
  cluster_id = digitalocean_database_cluster.beatbuddy-sgp-pg.id
  name       = "beatbuddy_track"
}

resource "digitalocean_database_db" "beatbuddy-artist" {
  cluster_id = digitalocean_database_cluster.beatbuddy-sgp-pg.id
  name       = "beatbuddy_artist"
}

resource "digitalocean_database_db" "beatbuddy-playlist" {
  cluster_id = digitalocean_database_cluster.beatbuddy-sgp-pg.id
  name       = "beatbuddy_playlist"
}

resource "digitalocean_database_db" "beatbuddy-keycloak" {
  cluster_id = digitalocean_database_cluster.beatbuddy-sgp-pg.id
  name       = "beatbuddy_keycloak"
}
