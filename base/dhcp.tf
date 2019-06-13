locals {
  dhcp_domain_names = [
    "${data.aws_region.region.name == "us-east-1" ? "ec2" : format("%s.compute", data.aws_region.region.name)}.internal",
    "my.local",
  ]
}

resource "aws_vpc_dhcp_options" "dhcp" {
  domain_name         = join(" ", local.dhcp_domain_names)
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = merge(local.tags,
    map(
      "Name", "${terraform.workspace}-dhcp",
    ),
  )
}

resource "aws_vpc_dhcp_options_association" "dhcp" {
  vpc_id          = aws_vpc.vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.dhcp.id
}

