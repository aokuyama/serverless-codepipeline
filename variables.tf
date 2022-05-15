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
