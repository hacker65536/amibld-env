data "github_repository" "repo" {
  name = var.github_repo
}


# automatically set to github
resource "aws_codebuild_webhook" "codebuild" {
  count         = length(local.platform_keys)
  project_name  = aws_codebuild_project.codebuild.*.name[count.index]
  branch_filter = "master"
}

/*
// only for GitHub Enterprise
resource "github_repository_webhook" "codebuild" {
  count  = length(local.platform_keys)
  active = true
  events = ["push", "pull_request"]

  // only "web"
  // name       = "web"
  repository = data.github_repository.repo.name

  configuration {
    url          = aws_codebuild_webhook.codebuild.*.payload_url[count.index]
    secret       = aws_codebuild_webhook.codebuild.*.secret[count.index]
    content_type = "json"
    insecure_ssl = true
  }
}
*/

output "output" {
  value = aws_codebuild_webhook.codebuild.*.payload_url
}

