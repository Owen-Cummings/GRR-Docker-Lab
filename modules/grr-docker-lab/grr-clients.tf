resource "docker_container" "nginx-grr-client" {
  count       = var.nginx_client_count
  image       = "nginx-grr-client:latest"
  name        = "nginx-grr-client-${count.index}"
  restart     = "always"
  working_dir = "/"
  depends_on  = [docker_network.grr-net]
  env         = ["grr_user=${var.grr_user}",
                "grr_pass=${var.grr_pass}",
                "grr_server_ip=${var.grr_server_ip}",
                "ssh_pass=${var.ssh_pass}"]

  networks_advanced {
    name          = var.network
    ipv4_address  = "172.20.0.${count.index + 21}"
  }

  provisioner "local-exec" {
    command = "docker exec nginx-grr-client-${count.index} /start.sh"
  }
}

resource "docker_container" "ubuntu-grr-client" {
  count       = var.ubuntu_client_count
  image       = "ubuntu-grr-client:latest"
  name        = "ubuntu-grr-client-${count.index}"
  restart     = "always"
  working_dir = "/"
  env         = ["grr_user=${var.grr_user}",
                "grr_pass=${var.grr_pass}",
                "grr_server_ip=${var.grr_server_ip}",
                "ssh_pass=${var.ssh_pass}"]

  depends_on = [docker_network.grr-net]

  networks_advanced {
    name          = var.network
    ipv4_address  = "172.20.0.${count.index + 41}"
  }

  provisioner "local-exec" {
    command = "docker exec ubuntu-grr-client-${count.index} /start.sh"
  }
}
