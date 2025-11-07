variable "table_arn" {
  type        = string
  description = "ARN of the DynamoDB table"
  nullable    = false
}

variable "project_name" {
  type        = string
  description = "Project name used for resource naming"
  nullable    = false
}
