

provider "docker" {
  host = "unix:///var/run/docker.sock"  //alter to your docker location
}

locals {
  nginx_client_count  = 4       //set number of nginx containers to deploy
  ubuntu_client_count = 4       //set number of ubuntu containers to deploy
  grr_pass            = "demo"  //set a password here to log into the GRR admin interface
  ssh_pass            = random_password.password.result   //password used by GRR server to ssh into clients
  network_subnet      = "172.20.0.0/16" //set network subnet here
}

module "grr-docker-lab" {
  source              = "./modules/grr-docker-lab/"
  nginx_client_count  = local.nginx_client_count
  ubuntu_client_count = local.ubuntu_client_count
  grr_pass            = local.grr_pass
  ssh_pass            = local.ssh_pass
  network_subnet      = local.network_subnet
  network_gateway     = cidrhost(local.network_subnet, 1)
  client_ips          = module.grr-docker-lab.client_ips
}

resource "random_password" "password" {
  length            = 16
  special           = true
  override_special  = "_%@"
}

resource "null_resource" "build-grr-client"{
  depends_on  = [module.grr-docker-lab]
  provisioner "local-exec" {
    command   = "sleep 20; docker exec grr-admin /buildclient.sh"
  }
  provisioner "local-exec" {
    when    = destroy
    command = "./scripts/rmimages.sh"
  }
}

resource "null_resource" "deploy-grr"{
  depends_on  = [null_resource.build-grr-client]
  provisioner "local-exec" {
    command   = "docker exec grr-admin /deploy.sh"
  }
}
