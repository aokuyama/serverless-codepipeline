terraform {
  required_version = "~> 1.0.0"
}
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}
data "aws_caller_identity" "self" {}

data "template_file" "buildspec" {
  template = file("./buildspec.yml")
  vars = {
    cred_url            = "http://169.254.170.2"
    app_dir             = "./app"
    bucket              = aws_s3_bucket.codepipeline.bucket
    bucket_dir          = "/state/"
    node_modules        = "node_modules"
    next                = ".next"
    sls                 = ".serverless"
    sls_next            = ".serverless_nextjs"
    deploy_domain       = var.demo_deploy_domain
    deploy_sub_domain   = var.demo_deploy_sub_domain
    next_public_api_url = var.demo_next_public_api_url
  }
}
