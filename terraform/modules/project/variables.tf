variable "github_token" {
  type = string
  description = "Github VCS oAuth Client Token ID"
}

variable "organization" {
  type = string
  default = "MediaCodex"
}

variable "name" {
  type = string
  description = "Project name"
}

variable "description" {
  type = string
  description = "Project description"
}

variable "tf_dir" {
  type = string
  description = "Terraform working directory"
  default = "terraform"
}


/*
 * Environments
 */
variable "env_dev" {
  type = bool
  description = "Development Environment"
  default = true
}

variable "env_prod" {
  type = bool
  description = "Production Environment"
  default = true
}