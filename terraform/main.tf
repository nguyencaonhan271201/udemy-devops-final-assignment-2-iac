terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Project = var.project_tag
    }
  }
}

module "database" {
  source     = "./modules/database"
  table_name = var.db_table_name
}

module "security" {
  source       = "./modules/security"
  table_arn    = module.database.table_arn
  project_name = var.project_name
}

module "lambda_generator" {
  source             = "./modules/lambda_generator"
  db_table_name      = var.db_table_name
  execution_role_arn = module.security.write_execution_role_arn
  project_name       = var.project_name
}

module "lambda_get_link" {
  source             = "./modules/lambda_link"
  db_table_name      = var.db_table_name
  execution_role_arn = module.security.read_execution_role_arn
  project_name       = var.project_name
}

module "api" {
  source                         = "./modules/api"
  lambda_generator_invoke_arn    = module.lambda_generator.invoke_arn
  lambda_get_link_invoke_arn     = module.lambda_get_link.invoke_arn
  lambda_generator_function_name = module.lambda_generator.function_name
  lambda_get_link_function_name  = module.lambda_get_link.function_name
  project_name                   = var.project_name
}

module "static_site" {
  source       = "./modules/static_site"
  project_name = var.project_name
}

module "cdn" {
  source                         = "./modules/cdn"
  static_site_bucket_domain_name = module.static_site.bucket_domain_name
  static_site_bucket_arn         = module.static_site.bucket_arn
  static_site_bucket_name        = module.static_site.bucket_name
  api_domain_name                = replace(module.api.api_endpoint, "https://", "")
  project_name                   = var.project_name
}
