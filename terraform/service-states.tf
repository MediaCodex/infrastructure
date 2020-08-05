/**
 * AWS Access
 */
module "remotestate_aws_access" {
  source    = "./modules/iam-remotestate"
  workspace = "development"
  service   = "aws-access"
  user      = "arn:aws:iam::949257948165:user/deployment/deploy-aws-access"
}

/**
 * Core
 */
module "remotestate_core" {
  source    = "./modules/iam-remotestate"
  workspace = "development"
  service   = "core"
  user      = "arn:aws:iam::949257948165:user/deployment/deploy-core"
}

/**
 * Website
 */
module "remotestate_website" {
  source    = "./modules/iam-remotestate"
  workspace = "development"
  service   = "website"
  user      = "arn:aws:iam::949257948165:user/deployment/deploy-website"
}

/**
 * Anime
 */
module "remotestate_anime" {
  source    = "./modules/iam-remotestate"
  workspace = "development"
  service   = "anime"
  user      = "arn:aws:iam::949257948165:user/deployment/deploy-anime"
}

/**
 * Companies
 */
module "companies" {
  source    = "./modules/iam-remotestate"
  workspace = "development"
  service   = "companies"
  user      = "arn:aws:iam::949257948165:user/deployment/deploy-companies"
}

/**
 * People
 */
module "people" {
  source    = "./modules/iam-remotestate"
  workspace = "development"
  service   = "people"
  user      = "arn:aws:iam::949257948165:user/deployment/deploy-people"
}

/**
 * Search
 */
module "search" {
  source    = "./modules/iam-remotestate"
  workspace = "development"
  service   = "search"
  user      = "arn:aws:iam::949257948165:user/deployment/deploy-search"
}
