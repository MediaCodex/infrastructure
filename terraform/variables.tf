locals {
  environment = "${lookup(var.environments, terraform.workspace, "dev")}"
}

variable "environments" {
  type = map(string)
  default = {
    development = "dev"
    production  = "prod"
  }
}

variable "default_tags" {
  type        = map(string)
  description = "Common resource tags for all resources"
  default = {
    Service = "infrastructure"
  }
}

variable "domains" {
  type = map
  default = {
    dev  = "mediacodex.dev"
    prod = "mediacodex.net"
  }
}
