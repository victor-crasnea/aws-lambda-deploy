data "aws_iam_policy_document" "assume_policy" {
  statement {

    effect = "Allow"
    principals {
      type = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "deploy" {
  name = "lambda_deploy"
  assume_role_policy = data.aws_iam_policy_document.assume_policy.json
  tags = {
    Name        = "Lambda deploy role"
    Environment = var.environment
    Project     = var.project_name
    Group       = var.group_name
    Country     = var.country_code
  }
}

resource "aws_iam_role_policy_attachment" "full_access" {
  policy_arn = "arn:aws:iam::aws:policy/AWSLambdaFullAccess"
  role = aws_iam_role.deploy.name
}

resource "aws_iam_role_policy_attachment" "base_role" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role = aws_iam_role.deploy.name
}