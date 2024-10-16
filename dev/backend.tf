terraform {
  backend "s3" {
    bucket = "jonag-terraform-store"
    key    = "env/dev/terraform.tfstate"
    region = "eu-west-2"
  }
}
