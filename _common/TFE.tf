# for terraform cloud remote sate
terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "shacker"

    //token        = "xxxxxxxxxxxxxx.atlasv1.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

    workspaces {
      name = "my-app-prod"
    }
  }
}
