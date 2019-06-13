data "terraform_remote_state" "base" {
  backend = "s3"

  config = {
    bucket  = var.remote_state_bucket
    key     = "base/${terraform.workspace}/terraform_state"
    region  = var.region
    profile = var.profile
  }
}
