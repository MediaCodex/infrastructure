terraform {
  backend "s3" {
    bucket         = "terraform-state-mediacodex"
    key            = "infrastructure.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}

variable "deploy_aws_roles" {
  type = map(string)
  default = {
    root = ""
    dev = "arn:aws:iam::949257948165:role/deploy-infrastructure"
  }
}

variable "deploy_aws_accounts" {
  type    = map(list(string))
  default = {
    root = ["939514526661"]
  }
}

provider "aws" {
  version             = "~> 2.0"
  region              = "eu-central-1"
  allowed_account_ids = var.deploy_aws_accounts[local.environment]
  assume_role {
    role_arn = var.deploy_aws_roles[local.environment]
  }
}