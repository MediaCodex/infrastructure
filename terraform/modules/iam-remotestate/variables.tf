locals {
  state_bucket = "arn:aws:s3:::terraform-state-mediacodex"
  plan_bucket  = "arn:aws:s3:::terraform-plan-mediacodex"
  lock_table   = "arn:aws:dynamodb:eu-central-1:939514526661:table/terraform-state-lock"

  account_dev = "949257948165"

  workspaces  = merge(
    var.user_dev == "" ? {} : { dev = var.user_dev },
    var.user_prod == "" ? {} : { prod = var.user_prod }
  )
}

variable "user_dev" {
  type        = string
  description = "ARN of the development IAM deploy user"
  default     = ""
}

variable "user_prod" {
  type        = string
  description = "ARN of the production IAM deploy user"
  default     = ""
}

variable "service" {
  type        = string
  description = "Service name"
}