# GRR-Docker-Lab
Local Google Rapid Response dev environment built with Terraform. Deploys specified number of Nginx and Ubuntu clients and enrolls them with the GRR server. A simple lab environment I've been using to work on a Google Rapid Response project.

*Currently only tested on Debian: will likely require tweaking for MacOS or Windows*

## Requirements
- A working Docker instance
- Terraform

## Usage
- In main.tf basic configuration parameters can be set
    - Default set to use 172.20.0.0/16 for network, this can be changed
- modules/grr-docker-lab/variables.tf for more granular configuration

`terraform init`

`terraform plan`

`terraform apply`

- Depending on number of resources being deployed this may take a moment to build the docker containers and deploy
- Voila! Now you have a Google Rapid Response instance to mess around with accessible in your subnet at host .10 (ie: 172.20.0.10 for 172.20.0.0/16)

Don't forget to `terraform destroy` when you're done.
