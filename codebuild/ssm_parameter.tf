resource "aws_ssm_parameter" "secret" {
  name        = "/${terraform.workspace}/${terraform.workspace}-packer-key"
  description = "The parameter description"
  type        = "SecureString"
  value       = file("./key_pair")
  tags        = local.tags
}
