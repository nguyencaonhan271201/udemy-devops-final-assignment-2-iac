variable "aws_region" {
  type    = string
  default = "ap-southeast-1"
}

variable "project_name" {
  type        = string
  nullable    = false
  description = "Project name used for resource naming"
}

variable "project_tag" {
  type        = string
  nullable    = false
  description = "Project name used for resource tagging"
}

variable "db_table_name" {
  type     = string
  nullable = false
}
