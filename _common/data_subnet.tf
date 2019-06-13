
# subnet_ids = [data.aws_subnet_ids.pri.ids]



#--------pub---------
data "aws_subnet_ids" "pub" {
  vpc_id = data.aws_vpc.vpc.id

  tags = {
    SubnetRole = "pub"
  }
}

locals {
  pub_subnet_ids_string = join(",", data.aws_subnet_ids.pub.ids)
  pub_subnet_ids_list   = split(",", local.pub_subnet_ids_string)
}

data "aws_subnet" "pub" {
  count = length(data.aws_subnet_ids.pub.ids)
  id    = local.pub_subnet_ids_list[count.index]
}


#--------pub_nat---------
data "aws_subnet_ids" "pub_nat" {
  vpc_id = data.aws_vpc.vpc.id

  tags = {
    SubnetRole = "pub_nat"
  }
}
locals {
  pub_nat_subnet_ids_string = join(",", data.aws_subnet_ids.pub_nat.ids)
  pub_nat_subnet_ids_list   = split(",", local.pub_nat_subnet_ids_string)
}

data "aws_subnet" "pub_nat" {
  count = length(data.aws_subnet_ids.pub_nat.ids)
  id    = local.pub_nat_subnet_ids_list[count.index]
}


#--------pri---------
data "aws_subnet_ids" "pri" {
  vpc_id = data.aws_vpc.vpc.id

  tags = {
    SubnetRole = "pri"
  }
}

locals {
  pri_subnet_ids_string = join(",", data.aws_subnet_ids.pri.ids)
  pri_subnet_ids_list   = split(",", local.pri_subnet_ids_string)
}

data "aws_subnet" "pri" {
  count = length(data.aws_subnet_ids.pri.ids)
  id    = local.pri_subnet_ids_list[count.index]
}




#--------pri_nat---------
data "aws_subnet_ids" "pri_nat" {
  vpc_id = data.aws_vpc.vpc.id

  tags = {
    SubnetRole = "pri_nat"
  }
}
locals {
  pri_nat_subnet_ids_string = join(",", data.aws_subnet_ids.pri_nat.ids)
  pri_nat_subnet_ids_list   = split(",", local.pri_nat_subnet_ids_string)
}

data "aws_subnet" "pri_nat" {
  count = length(data.aws_subnet_ids.pri_nat.ids)
  id    = local.pri_nat_subnet_ids_list[count.index]
}




/*
// single
data "aws_subnet" "pub" {
  filter {
    name   = "tag:SubnetRole"
    values = ["pub"]
  }
}

data "aws_subnet" "pri" {
  filter {
    name   = "tag:SubnetRole"
    values = ["pri"]
  }
}

data "aws_subnet" "pri_nat" {
  filter {
    name   = "tag:SubnetRole"
    values = ["pri_nat"]
  }
}
*/
/*
output "subnet_ids_pub" {
  value = data.aws_subnet_ids.pub.ids[1]
}
*/
