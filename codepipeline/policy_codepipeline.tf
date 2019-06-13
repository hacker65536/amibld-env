data "aws_iam_policy_document" "codepipeline" {
  statement {
    actions = [
      "s3:Put*",
      "s3:GetObjectVersion",
      "s3:GetObject",
      "s3:GetBucketVersioning",
    ]

    resources = [
      "${aws_s3_bucket.codepipeline.arn}",
      "${aws_s3_bucket.codepipeline.arn}/*",
    ]
  }

  statement {
    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
    ]

    resources = [
      "*",
    ]
  }
}
