locals {
  s3_origin_id = "devops-app-cf-origin-${aws_s3_bucket.devops_app_bucket.bucket_domain_name}"
  domain_name  = lookup({ prd = "cabd.link" }, var.env_name, "cabd.link")
}

resource "aws_cloudfront_origin_access_identity" "devops_app_access_identity" {
  comment = "Cloud front identity for devops_app_access_identity-${var.env_name}"
}

data "aws_acm_certificate" "acm_certificate" {
  domain      = local.domain_name
  statuses    = ["ISSUED"]
  most_recent = true
}

resource "aws_cloudfront_distribution" "devops_app_cf_distribution" {
  origin {
    domain_name = aws_s3_bucket.devops_app_bucket.bucket_regional_domain_name
    origin_id   = local.s3_origin_id
    origin_path = "/current"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.devops_app_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  aliases = [
    lookup({
      dev = "app.${local.domain_name}",
      dev2 = "app-dev.${local.domain_name}",
      stg = "app-staging.${local.domain_name}"
    }, var.env_name, "app-portal.${local.domain_name}")
  ]

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = local.s3_origin_id
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    lambda_function_association {
      event_type = "origin-response"
      lambda_arn = aws_lambda_function.lambda_edge_origin_response.qualified_arn
    }   
  }

  ordered_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    default_ttl            = 86400
    max_ttl                = 31536000
    min_ttl                = 0
    path_pattern           = "/*"
    smooth_streaming       = false
    target_origin_id       = local.s3_origin_id
    trusted_signers        = []
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      headers                 = []
      query_string            = true
      query_string_cache_keys = []

      cookies {
        forward           = "all"
        whitelisted_names = []
      }
    }
    lambda_function_association {
      event_type = "origin-response"
      lambda_arn = aws_lambda_function.lambda_edge_origin_response.qualified_arn
    }    
  }

  price_class = "PriceClass_All"

  custom_error_response {
    error_caching_min_ttl = 0
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
  }

  custom_error_response {
    error_caching_min_ttl = 0
    error_code            = 403
    response_code         = 200
    response_page_path    = "/index.html"
  }

  tags = {
    Environment = var.tag_environment
    Environment_Type = "${var.tag_name}-CloudFront"
    Environment_Name = local.tag_environment_name[var.env_name]
    Name        = "devops-app-${var.env_name}"
    Owner = var.tag_name
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = data.aws_acm_certificate.acm_certificate.arn
    minimum_protocol_version = "TLSv1.2_2018"
    ssl_support_method       = "sni-only"
  }
}