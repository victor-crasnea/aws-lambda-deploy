resource "aws_lambda_function" "deploy" {
  role              = aws_iam_role.deploy.arn
  handler           = "deploy.handler"
  runtime           = "python3.6"
  filename          = "${path.module}/files/deploy.zip"
  function_name     = "LambdaDeploy"
  source_code_hash  = filesha256("${path.module}/files/deploy.zip")
  timeout = 900
  tracing_config  {
    mode = "PassThrough"
  }
}
