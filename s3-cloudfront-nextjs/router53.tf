data "aws_route53_zone" "zone" {
  name = "cabd.link"
}

resource "aws_route53_record" "www-a" {
  zone_id = "${data.aws_route53_zone.zone.zone_id}"
  name    = local.app_dns
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.devops_app_cf_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.devops_app_cf_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}
