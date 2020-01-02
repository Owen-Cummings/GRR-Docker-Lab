resource "docker_container" "grr-admin" {
  image     = "grr-server:latest"
  name      = var.grr_server_hostname
  restart   = "always"
  env       = [ "ADMIN_PASSWORD=${var.grr_pass}",
                "EXTERNAL_HOSTNAME=${var.grr_server_hostname}",
                "SSH_PASS=${var.ssh_pass}",
                "NGINX_CLIENT_COUNT=${var.nginx_client_count}",
                "UBUNTU_CLIENT_COUNT=${var.nginx_client_count}"]

  depends_on = [docker_network.grr-net,
                docker_container.nginx-grr-client,
                docker_container.ubuntu-grr-client]
  ports {
    internal = 8000
    external = 8000
  }
  ports {
    internal = 8080
    external = 8080
  }
  networks_advanced {
    name          = var.network
    ipv4_address  = var.grr_server_ip
  }

  cpu_set = "0-1"
  memory  = 2000

}
