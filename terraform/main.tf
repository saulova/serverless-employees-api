terraform {
  required_version = "1.1.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.73.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""


  default_tags {
    tags = {
      Project   = "Serverless REST Employees API"
      CreatedAt = "2022-01-21"
      ManagedBy = "Terraform"
      Owner     = "Saulo"
      Env       = "dev"
    }
  }
}
