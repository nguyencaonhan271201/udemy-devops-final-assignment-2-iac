output "read_execution_role_arn" {
  value = aws_iam_role.lambda_read_execution_role.arn
}

output "write_execution_role_arn" {
  value = aws_iam_role.lambda_write_execution_role.arn
}
