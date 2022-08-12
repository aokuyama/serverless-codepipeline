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
    cred_url                               = "http://169.254.170.2"
    docker_compose_file                    = "deploy/docker-compose.yml"
    app_dir                                = "./app"
    bucket                                 = aws_s3_bucket.codepipeline.bucket
    bucket_dir                             = "/state/"
    node_modules                           = "node_modules"
    next                                   = ".next"
    sls                                    = ".serverless"
    sls_next                               = ".serverless_nextjs"
    deploy_domain                          = var.demo_deploy_domain
    deploy_sub_domain                      = var.demo_deploy_sub_domain
    next_public_api_url                    = var.demo_next_public_api_url
    image_allow_domain                     = var.demo_image_allow_domain
    next_public_firebase_api_key           = var.firebase_env.api_key
    next_public_firebase_auth_domain       = var.firebase_env.auth_domain
    next_public_firebase_project_id        = var.firebase_env.project_id
    next_public_firebase_storage_bucket    = var.firebase_env.storage_bucket
    next_public_firebase_message_sender_id = var.firebase_env.message_sender_id
    next_public_firebase_app_id            = var.firebase_env.app_id
  }
}
