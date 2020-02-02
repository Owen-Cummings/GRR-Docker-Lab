resource "docker_container" "grr-admin" {
  image     = "grr-server:latest"
  name      = var.grr_server_hostname
  restart   = "always"
  privileged= false
  env       = [ "ADMIN_PASSWORD=${var.grr_pass}",
                "EXTERNAL_HOSTNAME=${var.grr_server_hostname}"]

  depends_on = [docker_network.grr-net,
                docker_container.nginx-grr-client,
                docker_container.ubuntu-grr-client]

  volumes {
    volume_name = "grr-deploy-data"
    container_path = "/grr-deploy-data"
    read_only = false
  }

  networks_advanced {
    name          = var.network
    ipv4_address  = cidrhost(var.network_subnet, 10)
  }

}
