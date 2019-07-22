resource "aws_s3_bucket" "codebuild" {
  bucket_prefix = "${terraform.workspace}-codebuild"
  acl           = "private"
}
