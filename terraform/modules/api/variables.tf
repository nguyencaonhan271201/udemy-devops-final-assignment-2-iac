variable "lambda_generator_invoke_arn" {
  type     = string
  nullable = false
}

variable "lambda_get_link_invoke_arn" {
  type     = string
  nullable = false
}

variable "lambda_generator_function_name" {
  type     = string
  nullable = false
}

variable "lambda_get_link_function_name" {
  type     = string
  nullable = false
}

variable "project_name" {
  type        = string
  description = "Project name used for resource naming"
  nullable    = false
}
