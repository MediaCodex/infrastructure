provider "aws" {
  version = "~> 2.0"
  region  = "eu-west-2"
}

variable "default_tags" {
  type        = map(string)
  description = "Common resource tags for all resources"
  default = {
    Application = "MediaCodex"
  }
  # TODO: add stage
}

