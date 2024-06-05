terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.37.1"
    }
  }
}

variable "richardvu_dopat" {}
variable "vutiendat3601_dopat" {}

provider "digitalocean" {
  token = var.richardvu_dopat
}
