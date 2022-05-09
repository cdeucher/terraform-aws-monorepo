locals {
  tag_environment_name = {
    "dev" = "development"
    "stg" = "staging"
    "prd" = "production"
  }
  s3_origin_id = "devops-app-cf-origin-${aws_s3_bucket.devops_app_bucket.bucket_domain_name}"
  domain_name  = lookup({ prd = "cabd.link" }, var.env_name, "cabd.link")
  app_dns      = lookup({
      dev = "app.${local.domain_name}",
      dev2 = "app-dev.${local.domain_name}",
      stg = "app-staging.${local.domain_name}"
    }, var.env_name, "app-portal.${local.domain_name}")   
}