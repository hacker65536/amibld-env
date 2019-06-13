data "github_repository" "repo" {
  name = var.github_repo
}

locals {
  webhook_secret = "ga-secret"
}

resource "aws_codepipeline_webhook" "codepipeline" {
  name            = "${terraform.workspace}-codepipeline-webhook"
  authentication  = "GITHUB_HMAC"
  target_action   = "Source"
  target_pipeline = aws_codepipeline.codepipeline.name

  authentication_configuration {
    secret_token = local.webhook_secret
  }

  filter {
    json_path    = "$.ref"
    match_equals = "refs/heads/{Branch}"
  }
}


# Wire the CodePipeline webhook into a GitHub repository.
resource "github_repository_webhook" "codepipeline" {
  repository = data.github_repository.repo.name

  //name = "web"

  configuration {
    url          = aws_codepipeline_webhook.codepipeline.url
    secret       = local.webhook_secret
    content_type = "form"
    insecure_ssl = false
  }

  events = ["push"]
}
