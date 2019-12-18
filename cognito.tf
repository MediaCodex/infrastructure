resource "aws_cognito_user_pool" "default" {
  name = "mediacodex"
  tags = var.default_tags

  device_configuration {
    challenge_required_on_new_device      = true
    device_only_remembered_on_user_prompt = true
  }

  email_configuration {
    email_sending_account = "SES"
  }
}
