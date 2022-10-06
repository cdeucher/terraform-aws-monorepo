resource "aws_s3_bucket" "bucket" {
    bucket = var.bucket_name
    tags = {
        Name = "Bucket-${var.bucket_name}"
        Application = var.app_name
  }
}

resource "aws_s3_bucket_acl" "acl" {
    bucket = aws_s3_bucket.bucket.id
    acl    = "private"
}

resource "aws_s3_bucket_object" "current" {
  bucket = aws_s3_bucket.bucket.id
  content_type = "application/x-directory"
  key    = "current/"
}

resource "aws_s3_bucket_object" "static_sync" {
  for_each = toset([ for fn in fileset("${path.module}/src", "**/*") : fn if length(regexall("^logotypes\\/r12n\\/[0-9]{14}\\.jpg$", fn)) == 0 ])

  bucket = aws_s3_bucket.bucket.id
  key    = "current/${each.value}"
  source = "${path.module}/src/${each.value}"
  etag   = filemd5("${path.module}/src/${each.value}")
  content_type = "%{ if contains(["jpeg", ".jpg"], strrev(substr(strrev(each.value), 0, 4))) }image/jpeg%{ endif }%{ if contains(["png"], strrev(substr(strrev(each.value), 0, 3))) }image/png%{ endif }%{ if contains(["json"], strrev(substr(strrev(each.value), 0, 4))) }application/json%{ endif }%{ if contains(["apple-app-site-association"], strrev(substr(strrev(each.value), 0, 26))) }application/json%{ endif }%{ if contains(["html"], strrev(substr(strrev(each.value), 0, 4))) }text/html%{ endif }%{ if contains(["js"], strrev(substr(strrev(each.value), 0, 2))) }text/javascript%{ endif }%{ if contains(["css"], strrev(substr(strrev(each.value), 0, 3))) }text/css%{ endif }%{ if contains(["csv"], strrev(substr(strrev(each.value), 0, 3))) }text/csv%{ endif }"
}

data "aws_iam_policy_document" "devops_app_policy_document" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.access_identity.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "devops_app_bucket_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.devops_app_policy_document.json
}