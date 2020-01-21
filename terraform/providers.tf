/**
 * I don't particuarly like it, but apparently the only realistic way to dynamically
 * set the backend bucket name is by using the `TF_CLI_ARGS_init` env var.
 *
 * See README.md
 */
terraform {
  backend "s3" {
    bucket         = ""
    key            = "infrastructure.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "mediacodex-terraform-lock"
  }
}

provider "aws" {
  version             = "~> 2.0"
  region              = "eu-west-1"
  allowed_account_ids = var.aws_allowed_accounts
}

provider "cloudflare" {
  version = "~> 2.0"
}