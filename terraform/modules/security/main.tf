# IAM Roles for executing the Lambda function
resource "aws_iam_role" "lambda_write_execution_role" {
  name = "${var.project_name}-lambda-write-execution-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "lambda_read_execution_role" {
  name = "${var.project_name}-lambda-read-execution-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "dynamodb_write_policy" {
  name        = "${var.project_name}-dynamodb-write-policy"
  description = "Policy for Lambda function to write to DynamoDB table"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:PutItem"
      ],
      "Resource": "${var.table_arn}"
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "dynamodb_read_policy" {
  name        = "${var.project_name}-dynamodb-read-policy"
  description = "Policy for Lambda function to read DynamoDB table"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:GetItem"
      ],
      "Resource": "${var.table_arn}"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "lambda_dynamodb_read_policy_role_attachment" {
  role       = aws_iam_role.lambda_read_execution_role.name
  policy_arn = aws_iam_policy.dynamodb_read_policy.arn
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution_read_role_attachment" {
  role       = aws_iam_role.lambda_read_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_dynamodb_write_policy_role_attachment" {
  role       = aws_iam_role.lambda_write_execution_role.name
  policy_arn = aws_iam_policy.dynamodb_write_policy.arn
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution_write_role_attachment" {
  role       = aws_iam_role.lambda_write_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
