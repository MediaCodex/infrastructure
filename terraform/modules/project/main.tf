resource "github_repository" "default" {
  name        = var.name
  description = var.description
  visibility = "public"

  has_issues = true
  has_wiki = true
  has_projects = true
  has_downloads = false

  vulnerability_alerts = true
}

resource "tfe_workspace" "dev" {
  count = var.env_dev == true ? 1 : 0

  name         = "${var.name}-dev"
  organization = var.organization

  working_directory = var.tf_dir
  auto_apply = true

  vcs_repo {
    identifier = github_repository.default.full_name
    oauth_token_id = var.github_token
  }
}

resource "tfe_workspace" "prod" {
  count = var.env_prod == true ? 1 : 0

  name         = "${var.name}-prod"
  organization = var.organization

  working_directory = var.tf_dir
  auto_apply = false

  vcs_repo {
    identifier = github_repository.default.full_name
    oauth_token_id = var.github_token
  }
}