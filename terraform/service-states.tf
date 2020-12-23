/**
 * AWS Access
 */
module "remotestate_aws_access" {
  source   = "./modules/iam-remotestate"
  service  = "aws-access"
  user_dev = "arn:aws:iam::949257948165:user/deployment/deploy-aws-access"
}

/**
 * Core
 */
module "remotestate_core" {
  source   = "./modules/iam-remotestate"
  service  = "core"
  user_dev = "arn:aws:iam::949257948165:user/deployment/deploy-core"
}

/**
 * Website
 */
module "remotestate_website" {
  source   = "./modules/iam-remotestate"
  service  = "website"
  user_dev = "arn:aws:iam::949257948165:user/deployment/deploy-website"
}

/**
 * Anime
 */
module "remotestate_anime" {
  source   = "./modules/iam-remotestate"
  service  = "anime"
  user_dev = "arn:aws:iam::949257948165:user/deployment/deploy-anime"
}

/**
 * Companies
 */
module "remotestate_companies" {
  source   = "./modules/iam-remotestate"
  service  = "companies"
  user_dev = "arn:aws:iam::949257948165:user/deployment/deploy-companies"
}

/**
 * People
 */
module "remotestate_people" {
  source   = "./modules/iam-remotestate"
  service  = "people"
  user_dev = "arn:aws:iam::949257948165:user/deployment/deploy-people"
}

/**
 * Search
 */
module "remotestate_search" {
  source   = "./modules/iam-remotestate"
  service  = "search"
  user_dev = "arn:aws:iam::949257948165:user/deployment/deploy-search"
}
