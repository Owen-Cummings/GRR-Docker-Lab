resource "docker_container" "nginx-grr-client" {
  count       = var.nginx_client_count
  image       = "nginx-grr-client:latest"
  name        = "nginx-grr-client-${count.index}"
  restart     = "always"
  working_dir = "/"
  env         = ["SSH_PASS=${var.ssh_pass}"]

  depends_on  = [docker_network.grr-net]

  networks_advanced {
    name          = var.network
    ipv4_address  = cidrhost(cidrsubnet(var.network_subnet, 8, 1), "${count.index + 1}")
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
  env         = ["SSH_PASS=${var.ssh_pass}"]

  depends_on = [docker_network.grr-net]

  networks_advanced {
    name          = var.network
    ipv4_address  = cidrhost(cidrsubnet(var.network_subnet, 7, 1), "${count.index + 1}")
  }

  provisioner "local-exec" {
    command = "docker exec ubuntu-grr-client-${count.index} /start.sh"
  }
}

output "client_ips" {
  value = concat(docker_container.nginx-grr-client.*.ip_address, docker_container.ubuntu-grr-client.*.ip_address)
}
