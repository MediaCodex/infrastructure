/*
 * Special projects
 */
module "project_infrastructure" {
  source       = "./modules/project"
  github_token = data.tfe_oauth_client.github.oauth_token_id

  name        = "infrastructure"
  description = "General infrastructure that is not directly tied any environment, e.g. dev utils"

  env_dev = false
}

module "project_aws_access" {
  source       = "./modules/project"
  github_token = data.tfe_oauth_client.github.oauth_token_id

  name        = "aws-access"
  description = "AWS permissions"
}

module "project_website" {
  source       = "./modules/project"
  github_token = data.tfe_oauth_client.github.oauth_token_id

  name        = "website"
  description = "Primary website for https://mediacodex.net"
}

/*
 * Services
 */
module "project_service_core" {
  source       = "./modules/project"
  github_token = data.tfe_oauth_client.github.oauth_token_id

  name        = "service-core"
  description = "Resources that don't belong to any microservice in particular"
}

module "project_service_companies" {
  source       = "./modules/project"
  github_token = data.tfe_oauth_client.github.oauth_token_id

  name        = "service-companies"
  description = "API Microservice for companies"
}

module "project_service_search" {
  source       = "./modules/project"
  github_token = data.tfe_oauth_client.github.oauth_token_id

  name        = "service-search"
  description = "API Microservice for search"
}

module "project_service_anime" {
  source       = "./modules/project"
  github_token = data.tfe_oauth_client.github.oauth_token_id

  name        = "service-anime"
  description = "API Microservice for anime"
}

module "project_service_people" {
  source       = "./modules/project"
  github_token = data.tfe_oauth_client.github.oauth_token_id

  name        = "service-people"
  description = "API Microservice for people"
}

module "project_service_games" {
  source       = "./modules/project"
  github_token = data.tfe_oauth_client.github.oauth_token_id

  name        = "service-games"
  description = "API Microservice for games"
}