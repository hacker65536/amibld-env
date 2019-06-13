// usage
// tags="${merge(local.tags,map("Name","my-purpose-resource"))}"
// tags="${local.tags}"
variable "tags" {
  default = {
    Env   = "TestEnv"
    Build = "terraform"
  }
}

variable "author" {}

locals {
  tags = merge(
    var.tags,
    map(
      "Author", var.author,
      //      "TFversion", terraform.version,
    )
  )
}
