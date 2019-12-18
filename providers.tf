terraform {
  backend "s3" {
    bucket         = "mediacodex-terraform-state-dev"
    key            = "infrastructure.tfstate"
    region         = "eu-west-2"
    encrypt        = true
    dynamodb_table = "mediacodex-terraform-lock-dev"
  }
}

provider "aws" {
  version = "~> 2.0"
  region  = "eu-west-2"
  allowed_account_ids = var.aws_allowed_accounts
}

provider "aws" {
  alias = "eu-west-2"
  version = "~> 2.0"
  region  = "eu-west-1"
  allowed_account_ids = var.aws_allowed_accounts
}

provider "aws" {
  alias = "eu-west-1"
  version = "~> 2.0"
  region  = "eu-west-1"
  allowed_account_ids = var.aws_allowed_accounts
}

provider "cloudflare" {
  version = "~> 2.0"
}