locals {
  environment = "${lookup(var.environments, terraform.workspace, "dev")}"
}

variable "environments" {
  type = map(string)
  default = {
    root = "root"
    dev  = "dev"
    prod = "prod"
  }
}

variable "default_tags" {
  type        = map(string)
  description = "Common resource tags for all resources"
  default = {
    Service = "Infrastructure"
  }
  # TODO: add stage
}

variable "domains" {
  type = map
  default = {
    dev  = "mediacodex.dev"
    prod = "mediacodex.net"
  }
}
