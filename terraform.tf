provider "aws" {
  version = "~> 2.0"
  region  = "eu-west-2"
  allowed_account_ids = [
    "022451593157"
  ]
}

terraform {
  backend "s3" {
    bucket = "mediacodex-terraform-state-dev"
    key    = "infrastructure.tfstate"
    region = "eu-west-2"
    encrypt = true
    dynamodb_table = "mediacodex-terraform-lock-dev"
  }
}

variable "default_tags" {
  type        = "map"
  description = "Common resource tags for all resources"
  default = {
    Application = "MediaCodex"
    Service = "Infrastructure"
  }
  # TODO: add stage
}