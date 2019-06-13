data "aws_iam_policy_document" "codebuild" {
  statement {
    sid = "vpc1"

    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeVpcs",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    sid = "vpc2"

    actions = [
      "ec2:CreateNetworkInterfacePermission",
    ]

    resources = [
      "arn:aws:ec2:${data.aws_region.region.name}:${data.aws_caller_identity.caller_id.account_id}:network-interface/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "ec2:Subnet"

      values = data.aws_subnet.pri_nat.*.arn
    }

    condition {
      test     = "StringEquals"
      variable = "ec2:AuthorizedService"

      values = [
        "codebuild.amazonaws.com",
      ]
    }
  }

  statement {
    sid = "packer1"

    actions = [
      "ec2:AttachVolume",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:CopyImage",
      "ec2:CreateImage",
      "ec2:CreateKeypair",
      "ec2:CreateSecurityGroup",
      "ec2:CreateSnapshot",
      "ec2:CreateTags",
      "ec2:CreateVolume",
      "ec2:DeleteKeyPair",
      "ec2:DeleteSecurityGroup",
      "ec2:DeleteSnapshot",
      "ec2:DeleteVolume",
      "ec2:DeregisterImage",
      "ec2:DescribeImageAttribute",
      "ec2:DescribeImages",
      "ec2:DescribeInstances",
      "ec2:DescribeInstanceStatus",
      "ec2:DescribeRegions",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSnapshots",
      "ec2:DescribeSubnets",
      "ec2:DescribeTags",
      "ec2:DescribeVolumes",
      "ec2:DetachVolume",
      "ec2:GetPasswordData",
      "ec2:ModifyImageAttribute",
      "ec2:ModifyInstanceAttribute",
      "ec2:ModifySnapshotAttribute",
      "ec2:RegisterImage",
      "ec2:RunInstances",
      "ec2:StopInstances",
      "ec2:TerminateInstances",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    sid = "logs1"

    actions = [
      "logs:CreateLogGroup",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    sid = "logs2"

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      //"arn:aws:logs:${data.aws_region.region.name}:${data.aws_caller_identity.caller_id.account_id}:log-group:/aws/codebuild/${aws_codebuild_project.codebuild.name}:log-stream:*",
      "arn:aws:logs:${data.aws_region.region.name}:${data.aws_caller_identity.caller_id.account_id}:log-group:/aws/codebuild/*:log-stream:*",
    ]

    //"${aws_cloudwatch_log_group.codebuildlogs.arn}:log-stream:*",
    //"arn:aws:logs:${data.aws_region.region.name}:${data.aws_caller_identity.caller_id.account_id}:log-group:/aws/codebuild/${aws_codebuild_project.codebuild.name}",
  }

  statement {
    sid = "s3"

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.codebuild.arn}/*",
    ]
  }
  statement {
    sid = "dynamo1"

    actions = [
      "dynamodb:List*",
      "dynamodb:DescribeReservedCapacity*",
      "dynamodb:DescribeLimits",
      "dynamodb:DescribeTimeToLive"
    ]

    resources = [
      "*",
    ]
  }
  statement {
    sid = "dynamo2"

    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:DescribeStream",
      "dynamodb:DescribeTable",
      "dynamodb:Get*",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:BatchWriteItem",
      "dynamodb:DeleteItem",
      "dynamodb:UpdateItem",
      "dynamodb:PutItem"
    ]

    resources = [

      "arn:aws:dynamodb:${data.aws_region.region.name}:${data.aws_caller_identity.caller_id.account_id}:table/*",
    ]
  }

  statement {
    sid = "ecr1"

    actions = [
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    sid = "kms"

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
