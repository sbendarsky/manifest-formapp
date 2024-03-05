terraform {
  backend "s3" {
    bucket = "state-formapp"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}