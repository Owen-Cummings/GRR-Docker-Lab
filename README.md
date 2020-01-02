# GRR-Docker-Lab
Local Google Rapid Response dev environment built with Terraform. Deploys specified number of Nginx and Ubuntu clients and enrolls them with the GRR server. A simple lab environment I've been using to work on a Google Rapid Response project.

## Requirements
- A working Docker instance
- Terraform

## Usage
- In main.tf basic configuration parameters can be set
- modules/grr-docker-lab/variables.tf for more granular configuration
```terraform init```
```terraform plan```
```terraform apply```
- Depending on number of resources being deployed this may take a moment to build the docker containers and deploy
- Voila! Now you have a Google Rapid Response instance to mess around with
