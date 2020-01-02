

provider "docker" {
  host = "unix:///var/run/docker.sock"  //alter to your docker location
}

resource "random_password" "password" {
  length = 16
  special = true
  override_special = "_%@"
}

module "grr-docker-lab" {
  source              = "./modules/grr-docker-lab/"
  nginx_client_count  = 4       //set number of nginx containers to deploy
  ubuntu_client_count = 4       //set number of ubuntu containers to deploy
  grr_pass            = "demo"  //set a password here to log into the GRR admin interface
  ssh_pass            = random_password.password.result   //password used by GRR server to ssh into clients
}

resource "null_resource" "deploy-grr"{
  depends_on  = [module.grr-docker-lab]
  provisioner "local-exec" {
    command   = "sleep 20; docker exec grr-admin /deploy.sh"
  }
  provisioner "local-exec" {
    when    = destroy
    command = "./scripts/rmimages.sh"
  }
}
