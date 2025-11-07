# Create the bucket
resource "aws_s3_bucket" "static_site" {
  bucket        = "${var.project_name}-terraform-static"
  force_destroy = true
}

# Enable versioning
resource "aws_s3_bucket_versioning" "static_site" {
  bucket = aws_s3_bucket.static_site.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "static_site" {
  bucket = aws_s3_bucket.static_site.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Access Control list
# Block public access, access will be configured through CDN later
resource "aws_s3_bucket_public_access_block" "static_site" {
  bucket                  = aws_s3_bucket.static_site.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Upload initial static site assets, to be replaced by CI/CD
locals {
  static_files = fileset("${path.module}/source", "**")
}

resource "aws_s3_object" "static_assets" {
  for_each = { for file in local.static_files : file => file }

  bucket       = aws_s3_bucket.static_site.id
  key          = each.key
  source       = "${path.module}/source/${each.value}"
  etag         = filemd5("${path.module}/source/${each.value}")
  content_type = lookup(var.mime_types, regex("[^.]+$", each.key), null)
}
