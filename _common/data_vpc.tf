data "aws_vpc" "vpc" {
  id = data.terraform_remote_state.base.outputs.vpc_id
}
