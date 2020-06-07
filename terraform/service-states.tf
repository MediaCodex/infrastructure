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
