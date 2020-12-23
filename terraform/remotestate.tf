module "root_state" {
  source = "./modules/remotestate"
  tags   = var.default_tags
  prefix = "root"
}

module "dev_state" {
  source = "./modules/remotestate"
  tags   = var.default_tags
  providers = {
    aws = aws.dev
  }
  prefix = "dev"
}

# module "prod_state" {
#   source = "./modules/remotestate"
#   tags   = var.default_tags
#   providers = {
#     aws = aws.prod
#   }
#   prefix = "prod"
# }