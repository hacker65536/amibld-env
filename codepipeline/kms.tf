resource "aws_kms_key" "codepipeline" {
  description             = "${terraform.workspace}-codepipeline-kms"
  deletion_window_in_days = 7
  tags                    = merge(local.tags, map("Name", "${terraform.workspace}-codepipeline-kms"))

  //is_enabled  = true
  policy = data.aws_iam_policy_document.kms.json
}

resource "aws_kms_alias" "codepipeline" {
  name          = "alias/${terraform.workspace}-codepipeline-kms"
  target_key_id = aws_kms_key.codepipeline.key_id
}

output "key_id" {
  value = aws_kms_key.codepipeline.key_id
}
