variable "default_tags" {
  type        = map(string)
  description = "Common resource tags for all resources"
  default = {
    Service = "Infrastructure"
  }
  # TODO: add stage
}

variable "domain" {
  type        = string
  description = "Domain Name"
  default     = "mediacodex.net"
}

variable "aws_allowed_accounts" {
  type    = list(string)
  default = []
}

variable "aws_assume_role" {
  type = string
}
