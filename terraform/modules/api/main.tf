# Initiate the REST API gateway
resource "aws_apigatewayv2_api" "rest_api" {
  name          = "${var.project_name}-rest-api"
  protocol_type = "HTTP"
}

# Integrations for Lambda through proxy
resource "aws_apigatewayv2_integration" "lambda_generator_integration" {
  api_id             = aws_apigatewayv2_api.rest_api.id
  integration_type   = "AWS_PROXY"
  integration_uri    = var.lambda_generator_invoke_arn
  integration_method = "POST"
}

resource "aws_apigatewayv2_integration" "lambda_get_link_integration" {
  api_id             = aws_apigatewayv2_api.rest_api.id
  integration_type   = "AWS_PROXY"
  integration_uri    = var.lambda_get_link_invoke_arn
  integration_method = "POST"
}

# API Gateway routes
resource "aws_apigatewayv2_route" "post_generate_link" {
  api_id    = aws_apigatewayv2_api.rest_api.id
  route_key = "POST /api/generate-short-url"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_generator_integration.id}"
}

resource "aws_apigatewayv2_route" "get_link" {
  api_id    = aws_apigatewayv2_api.rest_api.id
  route_key = "GET /link/{short_url}"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_get_link_integration.id}"
}

# Stage - using $default to avoid path prefix
resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.rest_api.id
  name        = "$default"
  auto_deploy = true
}

# Grant permission to trigger Lambda functions
resource "aws_lambda_permission" "allow_generator_invoke" {
  statement_id  = "AllowAPIGatewayInvokeGenerator"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_generator_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.rest_api.execution_arn}/*/*"
}

resource "aws_lambda_permission" "allow_get_link_invoke" {
  statement_id  = "AllowAPIGatewayInvokeGetLink"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_get_link_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.rest_api.execution_arn}/*/*"
}
