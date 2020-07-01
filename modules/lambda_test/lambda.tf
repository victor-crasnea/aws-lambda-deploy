resource "aws_lambda_function" "test" {
  role              = aws_iam_role.test.arn
  handler           = "test.lambda_handler"
  runtime           = "python3.6"
  filename          = "${path.module}/files/test.zip"
  function_name     = "test"
  source_code_hash  = filesha256("${path.module}/files/test.zip")
  timeout = 900
  publish = true
  tracing_config  {
    mode = "PassThrough"
  }
}

resource "aws_lambda_alias" "test_lambda_alias" {
  name             = "prod"
  description      = "the production alias"
  function_name    = aws_lambda_function.test.arn
  function_version = aws_lambda_function.test.version
  lifecycle {
    ignore_changes = [ function_version ]
  }
}

output "lambda_version" {
  value = aws_lambda_function.test.version
}

output "lambda_function_name" {
  value = aws_lambda_function.test.function_name
}