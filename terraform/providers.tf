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
    dev  = ""
    prod = ""
  }
}

variable "deploy_aws_accounts" {
  type = map(list(string))
  default = {
    prod = ["939514526661"]
  }
}

provider "aws" {
  region              = "eu-central-1"
  allowed_account_ids = var.deploy_aws_accounts[local.environment]
  assume_role {
    role_arn = var.deploy_aws_roles[local.environment]
  }
}

provider "github" {
  organization = "MediaCodex"
}

provider "tfe" {}
data "tfe_oauth_client" "github" {
  oauth_client_id = "oc-ikn89H5cxDyCeunt"
}