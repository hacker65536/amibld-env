resource "aws_eip" "nat" {
  count = var.nat == 0 ? 0 : 1
  vpc   = true
  tags  = merge(local.tags, map("Name", "${terraform.workspace}-nat-ip"))
}


resource "aws_nat_gateway" "nat" {
  count         = var.nat == 0 ? 0 : 1
  allocation_id = aws_eip.nat.*.id[0]
  subnet_id     = aws_subnet.pub.*.id[0]
  depends_on    = [aws_eip.nat]
  tags          = merge(local.tags, map("Name", "${terraform.workspace}-ngw"))
}


