resource "aws_codebuild_project" "codebuild" {
  name          = "${terraform.workspace}-codepipeline-codebuild"
  description   = "with codepipeline"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type     = "S3"
    location = aws_s3_bucket.codebuild.bucket
  }

  /*
  // TODO
  logs_config {
    cloud_watch_logs {
      status     = "ENABLED"
      group_name = aws_cloudwatch_log_group.codebuildlogs.name
    }
  }
  */

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:2.0"
    type         = "LINUX_CONTAINER"

    // if using docker 
    privileged_mode = true

    environment_variable {
      name  = "ECR_REPO_URL"
      value = data.aws_ecr_repository.ecr.repository_url
    }

    /*
    environment_variable {
      "name"  = "SOME_KEY2"
      "value" = "SOME_VALUE2"
      "type"  = "PARAMETER_STORE"
    }
		*/
  }

  //  Build badges are not supported for CodePipeline source 
  // badge_enabled = true


  // source = [local.source_git]

  source {
    type = "CODEPIPELINE"

    // location        = "https://github.com/hacker65536/ci_test.git"
    // git_clone_depth = 1
  }
  vpc_config {
    vpc_id             = data.aws_vpc.vpc.id
    subnets            = data.aws_subnet_ids.pri_nat.ids
    security_group_ids = [data.aws_security_group.sec.id]
  }
  tags = merge(local.tags, map("Name", "${terraform.workspace}-codebuild"))
}
