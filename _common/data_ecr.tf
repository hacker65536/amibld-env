data "aws_ecr_repository" "ecr" {
  name = data.terraform_remote_state.ecr.outputs.ecr_name
}

