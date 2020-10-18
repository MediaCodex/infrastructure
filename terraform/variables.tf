locals {
  environment = "${lookup(var.environments, terraform.workspace, "dev")}"
}

variable "environments" {
  type = map(string)
  default = {
    prod = "prod"
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

variable "github_oauth_client" {
  type        = string
  description = "ID of the OAuth client for Github VCS access"
}