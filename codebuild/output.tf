output "badges" {
  value = aws_codebuild_project.codebuild.*.badge_url
}

output "codebuild_subnet" {
  value = data.aws_subnet_ids.pri_nat.ids
}
