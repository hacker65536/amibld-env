variable "region" {}
variable "profile" {}
variable "remote_state_bucket" {}

provider "aws" {
  region  = var.region
  profile = var.profile
}
