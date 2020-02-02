resource "docker_volume" "grr_deploy_data" {

  name    = "grr-deploy-data"
  driver  = "local"

}
