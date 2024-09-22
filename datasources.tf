data "aws_caller_identity" "current_identity" {}

data "aws_route53_zone" "zone" {
  name = var.root_domain
}
