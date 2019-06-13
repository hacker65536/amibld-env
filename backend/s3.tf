resource "aws_s3_bucket" "state" {
  bucket = "${terraform.workspace}-state"
  acl    = "private"
  tags   = local.tags

  force_destroy = true

  # comment out force_destroy if you want to leave data

  versioning {
    enabled = true
  }
}

output "bucket" {
  value = aws_s3_bucket.state.id
}
