terraform {
  backend "s3" {
    bucket         = "fullstack-labs-stage"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "fullstack-labs-tf"
    profile        = "aramzan"
  }
}