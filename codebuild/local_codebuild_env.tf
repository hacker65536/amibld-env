locals {
  codebuildb_env = [
    {
      name  = "SUBNET_ID"
      value = data.aws_subnet.pub.*.id[0]
    },
    {
      name  = "VPC_ID"
      value = data.aws_vpc.vpc.id
    },
    {
      name  = "SSH_KEY_PAIR_NAME"
      value = aws_key_pair.key.key_name
    },
    {
      name  = "SECURITY_GROUP_ID"
      value = data.aws_security_group.sec.id
    },
    {
      name  = "SSH_INTERFACE"
      value = "private_ip"
    },
    {
      name  = "USEFOR"
      value = "testbuild"
    },
    /*
    {
      name  = "ROLES"
      value = "base"
    },
    {
      name  = "AMI_USERS"
      value = "000000000000"
    },
    {
      name  = "AMI_REGIONS"
      value = "ap-northeast-1"
    },
    */
  ]
}
