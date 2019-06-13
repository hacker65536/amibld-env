variable "github_token" {}
variable "github_organization" {}
variable "github_repo" {}
variable "github_branch" {}

provider "github" {
  token        = var.github_token
  organization = var.github_organization
  version      = "~> 2.1"
}
