output "invoke_arn" {
  value = aws_lambda_function.generator_function.invoke_arn
}

output "function_name" {
  value = aws_lambda_function.generator_function.function_name
}
