data "aws_iam_policy_document" "kms" {
  statement {
    sid = "Enable IAM User Permissions"

    actions = [
      "kms:*",
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.caller_id.account_id}:root"]
    }

    resources = [
      "*",
    ]
  }

  /*
  statement {
    sid = "Allow access for Key Administrators"

    actions = [
      "kms:Create*",
      "kms:Describe*",
      "kms:Enable*",
      "kms:List*",
      "kms:Put*",
      "kms:Update*",
      "kms:Revoke*",
      "kms:Disable*",
      "kms:Get*",
      "kms:Delete*",
      "kms:TagResource",
      "kms:UntagResource",
      "kms:ScheduleKeyDeletion",
      "kms:CancelKeyDeletion",
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.caller_id.account_id}:role/Admin"]
    }

    resources = [
      "*",
    ]
  }

  statement {
    sid = "Allow use of the key"

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

    principals {
      type        = "AWS"
      identifiers = ["${aws_iam_role.codepipeline.arn}"]
    }
  }

  statement {
    sid = "Allow attachment of persistent resources"

    actions = [
      "kms:CreateGrant",
      "kms:ListGrants",
      "kms:RevokeGrant",
    ]

    resources = [
      "*",
    ]

    principals {
      type        = "AWS"
      identifiers = ["${aws_iam_role.codepipeline.arn}"]
    }

    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"

      values = [
        "true",
      ]
    }
  }
  */
}
