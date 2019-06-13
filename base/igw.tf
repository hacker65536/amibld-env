resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    local.tags,
    map(
      "Name", "${terraform.workspace}-igw"
    )
  )
}

