data "aws_caller_identity" "caller_id" {}

data "aws_canonical_user_id" "user_id" {}

data "aws_availability_zones" "azs" {}

data "aws_region" "region" {}

output "caller_id" {
  value = data.aws_caller_identity.caller_id.account_id
}

output "user_id" {
  value = data.aws_canonical_user_id.user_id.display_name
}

output "azs" {
  value = data.aws_availability_zones.azs.names
}

output "region" {
  value = data.aws_region.region.name
}
