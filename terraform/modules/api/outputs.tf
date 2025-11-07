output "api_source_arn" {
  value = "${aws_apigatewayv2_api.rest_api.execution_arn}/*/*"
}

output "api_endpoint" {
  value = aws_apigatewayv2_api.rest_api.api_endpoint
}
