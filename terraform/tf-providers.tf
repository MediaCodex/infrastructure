/**
 * I don't particuarly like it, but apparently the only realistic way to dynamically
 * set the backend bucket name is by using the `TF_CLI_ARGS_init` env var.
 *
 * See README.md
 */
terraform {
  backend "s3" {
    key            = "infrastructure.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}

provider "aws" {
  version             = "~> 2.0"
  region              = "eu-central-1"
  allowed_account_ids = var.aws_allowed_accounts
  assume_role {
    role_arn = var.aws_assume_role
  }
}

provider "cloudflare" {
  version = "~> 2.0"
}