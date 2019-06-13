resource "aws_iam_role" "codebuild" {
  name               = "${terraform.workspace}-codebuild-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_codebuild.json
}

locals {
  codebuild_role_policies = [
    #for codebuild
    "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess",

    #for ssm
    "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess",
  ]
}

resource "aws_iam_role_policy_attachment" "codebuild" {
  count      = length(local.codebuild_role_policies)
  role       = aws_iam_role.codebuild.name
  policy_arn = element(local.codebuild_role_policies, count.index)
}

resource "aws_iam_role_policy" "codebuild" {
  name   = "${terraform.workspace}-codebuild"
  role   = aws_iam_role.codebuild.id
  policy = data.aws_iam_policy_document.codebuild.json
}
