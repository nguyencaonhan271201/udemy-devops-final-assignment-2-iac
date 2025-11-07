output "invoke_arn" {
  value = aws_lambda_function.get_link_function.invoke_arn
}

output "function_name" {
  value = aws_lambda_function.get_link_function.function_name
}
