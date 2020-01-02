resource "docker_network" "grr-net"{

  name            = var.network
  attachable      = "true"
  check_duplicate = "true"

  ipam_config {
    subnet  = var.network_subnet
    gateway = var.network_gateway
  }

  provisioner "local-exec" {
    command = "./scripts/buildimages.sh"
  }
}
