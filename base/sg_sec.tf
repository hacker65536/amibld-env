variable "secips" {
  type = list
}
resource "aws_security_group" "sec" {
  name        = "${terraform.workspace}-sec"
  description = "sec"
  vpc_id      = aws_vpc.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.tags,
    map(
      "Name", "${terraform.workspace}-sec",
      "sg", "sec",
    ),
  )
}

resource "aws_security_group_rule" "sec_self" {
  type      = "ingress"
  from_port = 0
  to_port   = 65535
  protocol  = "-1"
  self      = true

  security_group_id = aws_security_group.sec.id
}

resource "aws_security_group_rule" "sec" {
  type        = "ingress"
  from_port   = 0
  to_port     = 65535
  protocol    = "-1"
  cidr_blocks = var.secips

  security_group_id = aws_security_group.sec.id
}

output "sec_sg" {
  value = aws_security_group.sec.id
}
