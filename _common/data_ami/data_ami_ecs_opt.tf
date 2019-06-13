data "aws_ami" "ecs_opt" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-20*-amazon-ecs-optimized"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "block-device-mapping.volume-type"
    values = ["gp2"]
  }

  owners = ["amazon"]
}
