variable "default_tags" {
  type        = map(string)
  description = "Common resource tags for all resources"
  default = {
    Application = "MediaCodex"
    Service     = "Infrastructure"
  }
  # TODO: add stage
}

variable "domain" {
  type        = string
  description = "Domain Name"
  default     = "mediacodex.net"
}