locals {
  bucket = "arn:aws:s3:::terraform-state-mediacodex"
  table  = "arn:aws:dynamodb:eu-central-1:939514526661:table/terraform-state-lock"
  account_dev = "949257948165"
}

variable "user" {
  type = string
  description = "ARN of the IAM deploy user"
}

variable "service" {
  type = string
  description = "Service name"
}

variable "workspace" {
  type = string
  description = "Terrafrom workspace"
}