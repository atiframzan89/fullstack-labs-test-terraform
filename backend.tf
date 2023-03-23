terraform {
  backend "s3" {
    bucket         = "fullstack-labs-main"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "fullstack-labs-tf"
    profile        = "aramzan"
  }
}