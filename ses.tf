resource "aws_ses_domain_identity" "default" {
  domain = var.domain
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
}

/*
 * Mail FROM
 */
resource "aws_ses_domain_mail_from" "defauly" {
  domain           = aws_ses_domain_identity.default.domain
  mail_from_domain = aws_ses_domain_identity.default.domain
}