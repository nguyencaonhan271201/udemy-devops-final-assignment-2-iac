variable "db_table_name" {
  type     = string
  nullable = false
}

variable "execution_role_arn" {
  type     = string
  nullable = false
}

variable "project_name" {
  type        = string
  description = "Project name used for resource naming"
  nullable    = false
}

