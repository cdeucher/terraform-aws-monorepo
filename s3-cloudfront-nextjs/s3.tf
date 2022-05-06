resource "aws_s3_bucket" "devops_app_bucket" {
  bucket = "devops-app-bucket-${var.env_name}"
  acl    = "public-read"
  #policy = templatefile("templates/policies/s3-policy.json", { bucket = "devops-app-bucket-${var.env_name}" })

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  tags = {
    Environment = var.tag_environment
    Environment_Type = "${var.tag_name}-s3-bucket"
    Environment_Name = local.tag_environment_name[var.env_name]
    Name        = "devops-app-${var.env_name}"
    Owner = var.tag_name
  }
}

resource "aws_s3_bucket_public_access_block" "access_block" {
  bucket = aws_s3_bucket.devops_app_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

data "aws_iam_policy_document" "policy_document" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.devops_app_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.devops_app_access_identity.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.devops_app_bucket.id
  policy = data.aws_iam_policy_document.policy_document.json
}