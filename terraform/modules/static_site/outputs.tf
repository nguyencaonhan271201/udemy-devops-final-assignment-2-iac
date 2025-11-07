output "bucket_domain_name" {
  value = aws_s3_bucket.static_site.bucket_regional_domain_name
}

output "bucket_arn" {
  value = aws_s3_bucket.static_site.arn
}

output "bucket_name" {
  value = aws_s3_bucket.static_site.id
}
