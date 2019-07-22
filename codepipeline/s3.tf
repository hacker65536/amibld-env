resource "aws_s3_bucket" "codepipeline" {
  bucket_prefix = "${terraform.workspace}-codepipeline"
  acl           = "private"
  force_destroy = true
  tags          = local.tags

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.codepipeline.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "codebuild" {
  bucket_prefix = "${terraform.workspace}-codepipeline-codebuild"
  acl           = "private"
  force_destroy = true
  tags          = local.tags
}
