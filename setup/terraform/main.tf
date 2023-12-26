# Configure heroku provider and AWS resource

terraform {
  required_providers {
    heroku = {
      source = "heroku/heroku"
      version = "5.1.4"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
