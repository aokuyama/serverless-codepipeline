variable "access_key" {
  type = string
}
variable "secret_key" {
  type = string
}
variable "region" {
  type    = string
  default = "ap-northeast-1"
}
variable "project_name" {
  type    = string
  default = "project1"
}
variable "uri_repository" {
  type    = string
  default = "https://example.com/project1"
}
variable "branch-name_deploy" {
  type    = string
  default = "deploy"
}
variable "demo_deploy_domain" {
  type    = string
  default = "example.com"
}
variable "demo_deploy_sub_domain" {
  type    = string
  default = "demo"
}
variable "demo_next_public_api_url" {
  type    = string
  default = "https://api.example.com"
}
