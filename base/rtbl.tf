resource "aws_default_route_table" "def" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id
  tags                   = merge(local.tags, map("Name", "def_rtbl"))
}

resource "aws_route_table" "pub" {
  tags   = merge(local.tags, map("Name", "pub_rtbl"))
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route" "pub" {
  route_table_id         = aws_route_table.pub.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  depends_on             = [aws_route_table.pub]
}

resource "aws_route_table" "pub_nat" {
  count  = var.nat == 0 ? 0 : 1
  tags   = merge(local.tags, map("Name", "pub_natrtbl"))
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route" "pub_nat" {
  count                  = var.nat == 0 ? 0 : 1
  route_table_id         = aws_route_table.pub_nat.*.id[0]
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  depends_on             = [aws_route_table.pub_nat]
}

//specific route
resource "aws_route" "pub2nat" {
  count                  = var.nat == 0 ? 0 : length(local.rt_dst_ips)
  route_table_id         = aws_route_table.pub_nat.*.id[0]
  destination_cidr_block = element(local.rt_dst_ips, count.index)
  nat_gateway_id         = aws_nat_gateway.nat.*.id[0]
  depends_on             = [aws_route_table.pub_nat]
}

resource "aws_route_table" "pri_nat" {
  count  = var.nat == 0 ? 0 : 1
  tags   = merge(local.tags, map("Name", "pri_natrtbl"))
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route" "pri_nat" {
  count                  = var.nat == 0 ? 0 : 1
  route_table_id         = aws_route_table.pri_nat.*.id[0]
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.*.id[0]
  depends_on             = [aws_route_table.pri_nat]
}

resource "aws_route_table_association" "pub" {
  count          = local.multi_azs
  subnet_id      = aws_subnet.pub.*.id[count.index]
  route_table_id = aws_route_table.pub.id
}

resource "aws_route_table_association" "pub_nat" {
  //count          = var.nat == 0 ? 0 : length(aws_subnet.pub_nat.*.id)
  count          = var.nat == 0 ? 0 : local.multi_azs
  subnet_id      = aws_subnet.pub_nat.*.id[count.index]
  route_table_id = aws_route_table.pub_nat.*.id[0]
}

resource "aws_route_table_association" "pri_nat" {
  //count          = var.nat == 0 ? 0 : length(aws_subnet.pri_nat.*.id)
  count          = var.nat == 0 ? 0 : local.multi_azs
  subnet_id      = aws_subnet.pri_nat.*.id[count.index]
  route_table_id = aws_route_table.pri_nat.*.id[0]
}

