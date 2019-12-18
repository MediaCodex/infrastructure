resource "aws_ses_domain_identity" "default" {
  domain = var.domain
  provider = aws.eu-west-1
}

/*
 * Verification
 */
resource "cloudflare_record" "ses_verification" {
  zone_id = cloudflare_zone.main.id
  name    = "_amazonses"
  type    = "TXT"
  value   = aws_ses_domain_identity.default.verification_token
  ttl     = 600
}
resource "aws_ses_domain_identity_verification" "default" {
  domain     = aws_ses_domain_identity.default.id
  depends_on = [cloudflare_record.ses_verification]
  provider = aws.eu-west-1
}