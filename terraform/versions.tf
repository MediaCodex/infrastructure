terraform {
  required_version = ">= 0.13"
  required_providers {
    aws2 = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.22.0"
    }
    github = {
      source  = "hashicorp/github"
      version = "~> 3.1"
    }
    aws = {
      source = "hashicorp/aws"
    }
  }
}
