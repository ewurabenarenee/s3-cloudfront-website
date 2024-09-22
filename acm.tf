resource "aws_acm_certificate" "ssl_cert" {
  provider          = aws.ue1
  domain_name       = var.subdomain != "" ? "${var.subdomain}.${var.root_domain}" : var.root_domain
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "ssl_cert_validation" {
  provider        = aws.ue1
  certificate_arn = aws_acm_certificate.ssl_cert.arn
  validation_record_fqdns = [
    for dvo in aws_acm_certificate.ssl_cert.domain_validation_options :
    dvo.resource_record_name
  ]
}
