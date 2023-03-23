terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5.0"
    }
    
}
}

provider "aws" {
  region    = var.region
  profile   = var.profile
  #version = "~> 3.0"
}
