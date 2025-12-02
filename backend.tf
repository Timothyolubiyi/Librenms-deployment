terraform {
  backend "s3" {
    bucket = "aws-tim"
    region = "eu-north-1"
    key    = "librenms/terraform.tfstate"
  }
}