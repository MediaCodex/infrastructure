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
    dev  = "arn:aws:iam::949257948165:role/OrganizationAccountAccessRole"
    prod = ""
  }
}


variable "deploy_aws_accounts" {
  type = map(list(string))
  default = {
    dev  = ["949257948165"]
    prod = [""]
  }
}

provider "aws" {
  region = "eu-central-1"
}

provider "aws" {
  alias  = "dev"
  region = "us-east-1"

  allowed_account_ids = var.deploy_aws_accounts["dev"]

  assume_role {
    role_arn = var.deploy_aws_roles["dev"]
  }
}

provider "aws" {
  alias  = "prod"
  region = "us-east-1"

  allowed_account_ids = var.deploy_aws_accounts["prod"]

  assume_role {
    role_arn = var.deploy_aws_roles["prod"]
  }
}

provider "github" {
  organization = "MediaCodex"
}

provider "tfe" {}
data "tfe_oauth_client" "github" {
  oauth_client_id = "oc-ikn89H5cxDyCeunt"
}