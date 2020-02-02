resource "docker_container" "nginx-grr-client" {
  count       = var.nginx_client_count
  image       = "nginx-grr-client:latest"
  name        = "nginx-grr-client-${count.index}"
  restart     = "always"
  working_dir = "/"
  depends_on  = [docker_network.grr-net]

  volumes {
    volume_name = "grr-deploy-data"
    container_path = "/grr-deploy-data"
    read_only = true
  }

  networks_advanced {
    name          = var.network
    ipv4_address  = cidrhost(cidrsubnet(var.network_subnet, 8, 1), "${count.index + 1}")
  }
}

resource "docker_container" "ubuntu-grr-client" {
  count       = var.ubuntu_client_count
  image       = "ubuntu-grr-client:latest"
  name        = "ubuntu-grr-client-${count.index}"
  restart     = "always"
  working_dir = "/"

  depends_on = [docker_network.grr-net]

  volumes {
    volume_name = "grr-deploy-data"
    container_path = "/grr-deploy-data"
    read_only = true
  }

  networks_advanced {
    name          = var.network
    ipv4_address  = cidrhost(cidrsubnet(var.network_subnet, 7, 1), "${count.index + 1}")
  }
}

output "client_names" {
  value = concat(docker_container.nginx-grr-client.*.name, docker_container.ubuntu-grr-client.*.name)
}
