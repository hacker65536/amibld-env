terraform {
  required_providers {
    aws = ">=2.14.0"
  }

  backend "s3" {}

  /*
    bucket               = "ENV-state"
    key                  = "terraform_state"
    region               = "us-east-1"
    profile              = "PROFILE"
    dynamodb_table       = "ENV-state-locking"
    workspace_key_prefix = "base"
    */
}
