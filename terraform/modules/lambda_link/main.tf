# Packaging the code into an archive file
data "archive_file" "generator_zip" {
  type        = "zip"
  source_dir  = "${path.module}/code"
  output_path = "${path.module}/lambda.zip"
}

locals {
  function_name = "${var.project_name}-get-link"
}

# Create Cloudwatch Log group for the Lambda function
resource "aws_cloudwatch_log_group" "lambda_link_log_group" {
  name              = "/aws/lambda/${local.function_name}"
  retention_in_days = 7
}

resource "aws_lambda_function" "get_link_function" {
  function_name    = local.function_name
  role             = var.execution_role_arn
  handler          = "app.lambda_handler"
  runtime          = "python3.11"
  architectures    = ["x86_64"]
  filename         = data.archive_file.generator_zip.output_path
  source_code_hash = data.archive_file.generator_zip.output_base64sha256
  environment {
    variables = {
      TABLE_NAME = var.db_table_name
    }
  }
}
