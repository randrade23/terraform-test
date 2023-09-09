variable "region" {
  type = string
  default = "us-east-1"
}

variable "app_port" {
  type = number
  default = 3000 
}

variable "repository_name" {
  type = string
  default = "app-repository"
}

variable "cluster_name" {
  type = string
  default = "app-cluster"
}

variable "container_resources" {
  type = map(any)
  default = {
    memory = 512,
    cpu = 256
  }
}