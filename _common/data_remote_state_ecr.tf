data "terraform_remote_state" "ecr" {
  backend = "s3"

  config = {
    bucket  = var.remote_state_bucket
    key     = "ecr/${terraform.workspace}/terraform_state"
    region  = data.aws_region.region.name
    profile = var.profile
  }
}
