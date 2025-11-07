variable "static_site_bucket_domain_name" {
  type     = string
  nullable = false
}

variable "static_site_bucket_arn" {
  type     = string
  nullable = false
}

variable "static_site_bucket_name" {
  type        = string
  nullable    = false
  description = "S3 bucket name for bucket policy"
}

variable "api_domain_name" {
  type     = string
  nullable = false
}

variable "project_name" {
  type        = string
  description = "Project name used for resource naming"
  nullable    = false
}
