resource "aws_s3_bucket" "codebuild" {
  bucket = "${terraform.workspace}-codebuild"
  acl    = "private"
}
