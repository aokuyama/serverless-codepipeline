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
    cred_url = "http://169.254.170.2"
  }
}
