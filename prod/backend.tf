terraform {
  backend "s3" {
    bucket = "jonag-terraform-store"
    key    = "env/prod/terraform.tfstate"
    region = "eu-west-2"
  }
}
