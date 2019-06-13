locals {
  vpc_cidr_block = "10.0.0.0/16"
}
resource "aws_vpc" "vpc" {
  cidr_block = local.vpc_cidr_block

  #default true
  enable_dns_support = true

  #default false
  enable_dns_hostnames = true

  tags = merge(
    local.tags,
    map(
      "Name", "${terraform.workspace}-vpc",
    ),
  )
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}
