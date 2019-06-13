data "aws_ami" "centos7" {
  most_recent = true

  filter {
    name   = "product-code"
    values = ["aw0evgkw8e5c1q413zgy5pjce"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "block-device-mapping.volume-type"
    values = ["gp2"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "image-type"
    values = ["machine"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "is-public"
    values = ["true"]
  }

  filter {
    name   = "ena-support"
    values = ["true"]
  }

  filter {
    name   = "sriov-net-support"
    values = ["simple"]
  }

  owners = ["679593333241"]
}
