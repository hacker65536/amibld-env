locals {
  container_img = data.aws_ecr_repository.ecr.repository_url
}

locals {
  platform_keys = [
    "centos6",
    "centos7",
    "amazonlinux",
    "amazonlinux2",
    "ubuntu18",
  ]

  amis = {
    centos6      = data.aws_ami.centos6.id
    centos7      = data.aws_ami.centos7.id
    amazonlinux  = data.aws_ami.amazonlinux.id
    amazonlinux2 = data.aws_ami.amazonlinux2.id
    ubuntu18     = data.aws_ami.ubuntu18.id
  }

  ssh_username = {
    centos6      = "centos"
    centos7      = "centos"
    amazonlinux  = "ec2-user"
    amazonlinux2 = "ec2-user"
    ubuntu18     = "ubuntu"
  }
}



resource "aws_codebuild_project" "codebuild" {
  count = length(local.platform_keys)

  name          = "${terraform.workspace}-codebuild-${element(local.platform_keys, count.index)}"
  description   = "build ${element(local.platform_keys, count.index)}"
  build_timeout = "50"
  service_role  = aws_iam_role.codebuild.arn

  artifacts {
    type = "NO_ARTIFACTS"

    /*
    type           = "S3"
    namespace_type = "BUILD_ID"
    location       = aws_s3_bucket.codebuild.bucket
    */
  }

  cache {
    type     = "S3"
    location = aws_s3_bucket.codebuild.bucket
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "${local.container_img}:latest"
    type         = "LINUX_CONTAINER"



    dynamic "environment_variable" {
      for_each = [for v in local.codebuildb_env : {
        key   = v.name
        value = v.value
      }]

      content {
        name  = environment_variable.value.key
        value = environment_variable.value.value
      }
    }


    environment_variable {
      name  = "PLATFORM"
      value = element(local.platform_keys, count.index)
    }

    environment_variable {
      name  = "SOURCE_AMI"
      value = lookup(local.amis, element(local.platform_keys, count.index))
    }

    environment_variable {
      name  = "SSH_USERNAME"
      value = lookup(local.ssh_username, element(local.platform_keys, count.index))
    }
    environment_variable {
      name  = "ROLES"
      value = "base"
    }

    environment_variable {
      name  = "SSH_KEY_PAIR"
      type  = "PARAMETER_STORE"
      value = aws_ssm_parameter.secret.name
    }
    environment_variable {
      name  = "PREFIX"
      value = terraform.workspace
    }

    /*
    environment_variable {
      name  = "SOME_KEY2"
      value = "SOME_VALUE2"
      type  = "PARAMETER_STORE"
    }
    */
  }

  badge_enabled = true

  source {
    type            = "GITHUB"
    location        = data.github_repository.repo.http_clone_url
    git_clone_depth = 1
  }



  vpc_config {
    vpc_id             = data.aws_vpc.vpc.id
    subnets            = data.aws_subnet_ids.pri_nat.ids
    security_group_ids = [data.aws_security_group.sec.id]
  }
  tags = merge(local.tags, map("Name", "${terraform.workspace}-codebuild"))

  depends_on = [aws_s3_bucket.codebuild]
}
