terraform {
  backend "s3" {
    bucket = "kuramiterra"
    key = "udemy/terraform_state"
    region = "us-east-1"
  }
}