resource "aws_key_pair" "key" {
  key_name   = "${terraform.workspace}-packer-key"
  public_key = file("./key_pair.pub")
}
