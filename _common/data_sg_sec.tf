#security_group_ids = ["${data.aws_security_group.sec.id}"]

data "aws_security_group" "sec" {
  vpc_id = data.aws_vpc.vpc.id

  filter {
    name   = "tag-key"
    values = ["sg"]
  }

  filter {
    name   = "tag-value"
    values = ["sec"]
  }
}
