terraform {
  backend "s3" {
    bucket         = "fullstack-labs-${var.environment}"
    key            = "terraform.tfstate"
    region         = "${var.region}"
    dynamodb_table = "fullstack-labs-tf"
  }
}