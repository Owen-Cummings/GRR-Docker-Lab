# File containing variables for lab configuration

variable "network" {
  type = string
  description = "Name of network to be created"
  default = "grr-net" //set network name here
}

variable "network_subnet"{
  type = string
  description = "Subnet for lab network in CIDR notation"
  default = "172.20.0.0/16"   //set subnet range here
}

variable "network_gateway"{
  type = string
  description = "Default gateway for lab network"
  default = "172.20.0.1"    //set default gateway here
}

variable "grr_server_ip" {
  type = string
  description = "IP of the GRR server"
  default = "172.20.0.10"   //set ip here
}

variable "grr_server_hostname" {
  type = string
  description = "Hostname for GRR server"
  default = "grr-admin"   //set username here
}

variable "grr_user" {
  type = string
  description = "User for GRR server"
  default = "admin"   //set username here
}

variable "grr_pass" {
  type = string
  description = "Password for GRR server"
  default = ""   //set password here
}

variable "nginx_client_count" {
  type = number
  description = "Number of nginx servers to create"
  default = 1
}

variable "ubuntu_client_count" {
  type = number
  description = "Number of ubuntu clients to create"
  default = 1
}
