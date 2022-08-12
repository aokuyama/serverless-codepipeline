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
variable "demo_image_allow_domain" {
  type    = string
  default = "api.example.com"
}
variable "firebase_env" {
  type = object({
    api_key           = string
    auth_domain       = string
    project_id        = string
    storage_bucket    = string
    message_sender_id = string
    app_id            = string
  })
}
