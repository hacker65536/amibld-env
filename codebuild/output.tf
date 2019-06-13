output "badges"{
value =aws_codebuild_project.codebuild.*.badge_url
}
