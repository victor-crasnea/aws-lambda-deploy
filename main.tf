provider "template" {
  version = "~> 2.1"
}
provider "aws" {
  version    = "~> 2.7"
  profile    = terraform.workspace
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "lambda_deploy" {
  source = "./modules/lambda_deploy"
}

module "lambda_test" {
  source = "./modules/lambda_test"
}

output "lambda_version" {
  value = module.lambda_test.lambda_version
}

output "lambda_function_name" {
  value = module.lambda_test.lambda_function_name
}