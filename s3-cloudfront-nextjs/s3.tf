resource "aws_s3_bucket" "devops_app_bucket" {
  bucket = "devops-app-bucket-${var.env_name}"
  acl    = "public-read"
  
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

resource "aws_s3_bucket_public_access_block" "devops_app_access_block" {
  bucket = aws_s3_bucket.devops_app_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  restrict_public_buckets = false
  ignore_public_acls      = false
}

resource "aws_s3_bucket_ownership_controls" "website_controls" {
  bucket = aws_s3_bucket.devops_app_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

data "aws_iam_policy_document" "devops_app_policy_document" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.devops_app_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "devops_app_bucket_policy" {
  bucket = aws_s3_bucket.devops_app_bucket.id
  policy = data.aws_iam_policy_document.devops_app_policy_document.json
}
